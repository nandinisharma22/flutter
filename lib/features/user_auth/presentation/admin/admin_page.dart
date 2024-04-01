import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final GlobalKey qrKey = GlobalKey();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: _buildQrScanner(context),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Scan QR Code",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrScanner(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        _onQRViewCreated(context, controller);
      },
    );
  }


  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      // Handle scanned QR code data here
      String scannedCode = scanData.code!;
      List<String> qrDataParts = scannedCode.split('-');
      String userId = qrDataParts[0];
      String date = qrDataParts[1];
      String time = qrDataParts[2];

      _showPopup(context, userId, date, time);
    });
  }

  void _showPopup(BuildContext context, String userId, String date, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Scanned QR Code Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("User ID: $userId"),
              Text("Date: $date"),
              Text("Time: $time"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
