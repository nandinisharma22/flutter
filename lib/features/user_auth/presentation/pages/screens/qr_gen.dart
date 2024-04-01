import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart' as img; // Import image package
import 'dart:typed_data';
import 'dart:ui' as ui;
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
      body: Center(
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
