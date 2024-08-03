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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding = 16.0;
          double verticalPadding = 8.0;
          double fontSizeTitle = 18.0;
          double fontSizeBody = 16.0;

          if (constraints.maxWidth > 1200) {
            // Tablet and Web
            horizontalPadding = 32.0;
            verticalPadding = 16.0;
            fontSizeTitle = 24.0;
            fontSizeBody = 20.0;
          } else if (constraints.maxWidth > 600) {
            // Tablet
            horizontalPadding = 24.0;
            verticalPadding = 12.0;
            fontSizeTitle = 20.0;
            fontSizeBody = 18.0;
          }

          return Consumer<CardamomDataProvider>(
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
                  onRefresh: _fetchData,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal,
                              child:
                                  Icon(Icons.local_offer, color: Colors.white),
                            ),
                            title: Text(
                              'Auctioneer: ${data.auctioneer}',
                              style: TextStyle(fontSize: fontSizeTitle),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text('Date: ${data.date}',
                                    style: TextStyle(fontSize: fontSizeBody)),
                                Text('Lots: ${data.lots}',
                                    style: TextStyle(fontSize: fontSizeBody)),
                                Text('Total Arrived: ${data.totalArrived}',
                                    style: TextStyle(fontSize: fontSizeBody)),
                                Text('Quantity Sold: ${data.qtySold}',
                                    style: TextStyle(fontSize: fontSizeBody)),
                                SizedBox(height: 8),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Max Price: ',
                                        style:
                                            TextStyle(fontSize: fontSizeBody),
                                      ),
                                      TextSpan(
                                        text: '${data.maxPrice}',
                                        style: TextStyle(
                                          fontSize: fontSizeBody,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Average Price: ',
                                        style:
                                            TextStyle(fontSize: fontSizeBody),
                                      ),
                                      TextSpan(
                                        text: '${data.avgPrice}',
                                        style: TextStyle(
                                          fontSize: fontSizeBody,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('Type: ${data.type}',
                                    style: TextStyle(fontSize: fontSizeBody)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () => _shareData(data),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.teal),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CardamomDetailScreen(data: data),
                                ),
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
