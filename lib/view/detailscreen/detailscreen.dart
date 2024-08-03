import 'package:cardamomrate/model/cardamomdatamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

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
            // Web
            horizontalPadding = 64.0;
            verticalPadding = 32.0;
            fontSizeTitle = 24.0;
            fontSizeBody = 20.0;
          } else if (constraints.maxWidth > 600) {
            // Tablet
            horizontalPadding = 32.0;
            verticalPadding = 16.0;
            fontSizeTitle = 22.0;
            fontSizeBody = 18.0;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 800),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Auctioneer: ${data.auctioneer}',
                            style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          _buildDetailRow('Date', data.date, fontSizeBody),
                          _buildDetailRow('Lots', data.lots, fontSizeBody),
                          _buildDetailRow(
                              'Total Arrived', data.totalArrived, fontSizeBody),
                          _buildDetailRow(
                              'Quantity Sold', data.qtySold, fontSizeBody),
                          SizedBox(height: 16),
                          _buildPriceRow('Max Price', data.maxPrice,
                              fontSizeBody, Colors.green),
                          _buildPriceRow('Average Price', data.avgPrice,
                              fontSizeBody, Colors.blue),
                          SizedBox(height: 16),
                          _buildDetailRow('Type', data.type, fontSizeBody),
                          SizedBox(height: 24),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () => _shareData(),
                              icon: Icon(Icons.share),
                              label: Text('Share Details'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.teal,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                textStyle: TextStyle(fontSize: fontSizeBody),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
      String title, String value, double fontSize, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareData() async {
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
}
