import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.teal,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding = 16.0;
          double verticalPadding = 8.0;
          double fontSizeTitle = 24.0;
          double fontSizeBody = 18.0;

          if (constraints.maxWidth > 1200) {
            // Tablet and Web
            horizontalPadding = 32.0;
            verticalPadding = 16.0;
            fontSizeTitle = 30.0;
            fontSizeBody = 22.0;
          } else if (constraints.maxWidth > 600) {
            // Tablet
            horizontalPadding = 24.0;
            verticalPadding = 12.0;
            fontSizeTitle = 28.0;
            fontSizeBody = 20.0;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About This App',
                    style: TextStyle(
                        fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This app provides up-to-date information on cardamom prices, including auctioneer details, lots, total arrived quantity, quantity sold, maximum and average prices, and type of cardamom.',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Features:',
                    style: TextStyle(
                        fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- Fetches latest data from API every 5 minutes',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  Text(
                    '- Displays data from local storage when offline',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  Text(
                    '- Responsive design for mobile, tablet, and web',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Licenses:',
                    style: TextStyle(
                        fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This app uses various open-source libraries. Please refer to the respective licenses included in the source code.',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Detailed Information:',
                    style: TextStyle(
                        fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'For more information about the technologies used in this app and its development, please visit our website or contact us directly.',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Copyright:',
                    style: TextStyle(
                        fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '© 2024 crypted_data-inc. All rights reserved.',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Terms and Conditions:',
                    style: TextStyle(
                        fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'By using this app, you agree to the terms and conditions outlined on our website. For more details, please visit our terms and conditions page.',
                    style: TextStyle(fontSize: fontSizeBody),
                  ),
                  SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: 'Developed by Ajas pj, for more mail to ',
                      style: TextStyle(fontSize: fontSizeBody),
                      children: [
                        TextSpan(
                          text: 'ajaspj123@gmail.com',
                          style: TextStyle(
                            fontSize: fontSizeBody,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontFamily:
                                'Courier', // Change font family if needed
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
