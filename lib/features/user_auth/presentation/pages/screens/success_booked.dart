import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SlotWidget extends StatelessWidget {
  final String slotTime;
  final String qrData;

  const SlotWidget({
    Key? key,
    required this.slotTime,
    required this.qrData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.white, // Adjust the container's style as needed
            // child: QrImage(data: qrData.isNotEmpty ? qrData : 'No QR data'),
          ),
          Text('Slot Time: $slotTime'),
        ],
      ),
    );
  }
}

class SlotsWidget extends StatelessWidget {
  final String userId;

  const SlotsWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference userTicketsCollection = FirebaseFirestore.instance
        .collection('tickets')
        .doc(userId)
        .collection('user_tickets');

    return StreamBuilder<QuerySnapshot>(
      stream: userTicketsCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No data found.');
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot userTicket) {
            String date = userTicket.id;

            return ExpansionTile(
              title: Text('Date: $date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: userTicket.reference.collection('slots').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No slots data found for date: $date');
                    }

                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((DocumentSnapshot slot) {
                        String slotTime = slot.id; // Assuming document ID is the slot time
                        String qrData = slot['qr_image']; // Assuming 'qr_image' is the field name for QR data

                        return ListTile(
                          title: Text('Slot Time: $slotTime'),
                          subtitle: SlotWidget(slotTime: slotTime, qrData: qrData),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}