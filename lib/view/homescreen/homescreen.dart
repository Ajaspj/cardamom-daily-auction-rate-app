import 'package:cardamomrate/controller/Apicontroller.dart';
import 'package:cardamomrate/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardamomScreen extends StatefulWidget {
  @override
  _CardamomScreenState createState() => _CardamomScreenState();
}

class _CardamomScreenState extends State<CardamomScreen> {
  late Future<List<CardamomData>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchCardamomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardamom Prices'),
      ),
      body: FutureBuilder<List<CardamomData>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset("assets/animations/cardamom.json"),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CardamomData data = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Auctioneer: ${data.auctioneer}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${data.date}'),
                        Text('Lots: ${data.lots}'),
                        Text('Total Arrived: ${data.totalArrived}'),
                        Text('Quantity Sold: ${data.qtySold}'),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Max Price: ',
                                  style: DefaultTextStyle.of(context).style),
                              TextSpan(
                                text: '${data.maxPrice}',
                                style: TextStyle(
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
                                  style: DefaultTextStyle.of(context).style),
                              TextSpan(
                                text: '${data.avgPrice}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('Type: ${data.type}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
