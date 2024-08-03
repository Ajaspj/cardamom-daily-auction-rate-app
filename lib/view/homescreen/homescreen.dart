import 'package:cardamomrate/model/cardamomdatamodel.dart';
import 'package:cardamomrate/providers/cardamomdataprovider.dart';
import 'package:cardamomrate/view/aboutscreen/aboutscreen.dart';
import 'package:cardamomrate/view/detailscreen/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CardamomScreen extends StatefulWidget {
  @override
  _CardamomScreenState createState() => _CardamomScreenState();
}

class _CardamomScreenState extends State<CardamomScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isFetching) {
        _fetchData();
      }
    });
  }

  Future<void> _loadData() async {
    await Provider.of<CardamomDataProvider>(context, listen: false)
        .loadDataFromLocal();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isFetching = true;
    });
    await Provider.of<CardamomDataProvider>(context, listen: false)
        .fetchCardamomData();
    setState(() {
      _isFetching = false;
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<CardamomDataProvider>(context, listen: false)
        .fetchCardamomData(refresh: true);
  }

  Future<void> _shareData(CardamomData data) async {
    final String text = 'Cardamom Data:\n'
        'Auctioneer: ${data.auctioneer}\n'
        'Date: ${data.date}\n'
        'Lots: ${data.lots}\n'
        'Total Arrived: ${data.totalArrived}\n'
        'Quantity Sold: ${data.qtySold}\n'
        'Max Price: ${data.maxPrice}\n'
        'Average Price: ${data.avgPrice}\n'
        'Type: ${data.type}';

    await FlutterShare.share(
      title: 'Share Cardamom Data',
      text: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardamom Prices'),
        backgroundColor: Colors.teal,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutScreen(),
                      ));
                },
                child: Icon(Icons.info)),
          ),
        ],
      ),
      body: Consumer<CardamomDataProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.cardamomData.isEmpty) {
            return Center(
              child: Lottie.asset(
                  "assets/animations/Animation - 1722503461417 (1).json"),
            );
          } else if (provider.cardamomData.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: provider.cardamomData.length +
                    (provider.hasMoreData ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == provider.cardamomData.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  CardamomData data = provider.cardamomData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.local_offer, color: Colors.white),
                        ),
                        title: Text(
                          'Auctioneer: ${data.auctioneer}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text('Date: ${data.date}',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('Lots: ${data.lots}',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('Total Arrived: ${data.totalArrived}',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('Quantity Sold: ${data.qtySold}',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('Max Price: ${data.maxPrice}',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('Average Price: ${data.avgPrice}',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('Type: ${data.type}',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () => _shareData(data),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CardamomDetailScreen(data: data)),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
