import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRView extends StatelessWidget {
  final String userId;
  final String date;
  final String slot;

  const QRView({
    Key? key,
    required this.userId,
    required this.date,
    required this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate the data for the QR code
    String qrData = '$userId-$slot-$date';

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Stack(
        children: [
          // Background color for the entire page
          Container(
            color: Colors.blueGrey,
            // color:  Color(0x8BCBFFFF),
            // Color(0x8BCBFFFF),// Set the background color here
          ),
          // Centered QR code and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                SizedBox(height: 40), // Adding space between QR code and text
                Text(
                  'Booking Successful!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
