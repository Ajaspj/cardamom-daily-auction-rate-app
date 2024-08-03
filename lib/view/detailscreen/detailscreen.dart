import 'package:cardamomrate/model/cardamomdatamodel.dart';
import 'package:flutter/material.dart';

class CardamomDetailScreen extends StatelessWidget {
  final CardamomData data;

  CardamomDetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardamom Details'),
        backgroundColor: Colors.teal,
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

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Auctioneer: ${data.auctioneer}',
                      style: TextStyle(fontSize: fontSizeTitle),
                    ),
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
                            style: TextStyle(fontSize: fontSizeBody),
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
                            style: TextStyle(fontSize: fontSizeBody),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
