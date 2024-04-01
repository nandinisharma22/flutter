// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class FirebaseAuthServices{
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//
//   Future<User?> signUpWithEmailandPassword(String email, String password) async{
//     try{
//       UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     }on FirebaseAuthException catch  (e) {
//       print('Failed with error code: ${e.code}');
//       print(e.message);
//     }
//     return null;
//   }
//
//   Future<User?> signInWithEmailandPassword(String email, String password) async{
//     try{
//       UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     }on FirebaseAuthException catch  (e) {
//       print('Failed with error code: ${e.code}');
//       print(e.message);
//     }
//     return null;
//   }
//
// // class AppointmentManager {
// // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// // Future<void> bookAppointment(DateTime selectedDate, int selectedSlot, String userId) async {
// // String dateString = selectedDate.toIso8601String().substring(0, 10);
// //
// // // Check if the document for the selected date exists
// // DocumentSnapshot dateSnapshot =
// // await _firestore.collection('booking').doc(dateString).get();
// //
// // if (dateSnapshot.exists) {
// // // Document exists, get the current slot data
// // Map<String, dynamic>? slotData = (dateSnapshot.data() as Map<String, dynamic>?) ?? {};
// //
// // // Check if the slot is available
// // int count = slotData['slot$selectedSlot'] ?? 0;
// // if (count < 150) {
// // // Slot is available, update slot data with user ID
// // if (!slotData.containsKey('users')) {
// // slotData['users'] = [userId];
// // } else {
// // List<dynamic> users = List.from(slotData['users']);
// // users.add(userId);
// // slotData['users'] = users;
// // }
// // slotData['slot$selectedSlot'] = count + 1;
// //
// // // Update the document in Firestore
// // await _firestore.collection('booking').doc(dateString).set(slotData);
// // print('Appointment booked successfully!');
// // } else {
// // // Slot is fully booked
// // print('Slot is fully booked. Please choose another slot.');
// // }
// // } else {
// // // Document does not exist, create a new document and initialize slots with user ID
// // Map<String, dynamic> initialSlots = {'users': [userId]};
// // for (int i = 1; i <= 8; i++) {
// // initialSlots['slot$i'] = i == selectedSlot ? 1 : 0;
// // }
// //
// // // Set the document in Firestore
// // await _firestore.collection('booking').doc(dateString).set(initialSlots);
// // print('Appointment booked successfully!');
// // }
// // }
// //
// }
//
//
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AppointmentManager {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> bookAppointment(String dateString, int selectedSlot,
//       String userId) async {
//     // Create a document reference with the selected date
//     DocumentReference bookingRef = _firestore.collection('bookings').doc(dateString);
//
//     // Get the document snapshot for the selected date
//     DocumentSnapshot dateSnapshot = await bookingRef.get();
//
//     if (!dateSnapshot.exists) {
//       // Document does not exist, create a new document
//       Map<String, dynamic> initialSlots = {
//         'slot$selectedSlot': {
//           'numberOfTicketsBooked': 1,
//           'users': [userId],
//         }
//       };
//
//       // Set the document in Firestore
//       await bookingRef.set(initialSlots);
//       print('Appointment booked successfully!');
//     } else {
//       // Document exists, get the current slot data
//       Map<String, dynamic>? slotData = dateSnapshot.data() as Map<String, dynamic>?;
//
//       // Check if the slot is available
//       Map<String, dynamic>? selectedSlotData = slotData?['slot$selectedSlot'];
//
//       if (selectedSlotData != null) {
//         // Slot exists
//         int count = selectedSlotData['numberOfTicketsBooked'] ?? 0;
//         if (count < 3) {
//           // Slot is available, update slot data with user ID
//           List<dynamic> users = List.from(selectedSlotData['users']);
//           users.add(userId);
//
//           // Update slot data
//           selectedSlotData['numberOfTicketsBooked'] = count + 1;
//           selectedSlotData['users'] = users;
//
//           // Update the document in Firestore
//           await bookingRef.update({ 'slot$selectedSlot': selectedSlotData });
//           print('Appointment booked successfully!');
//         } else {
//           // Slot is fully booked
//           print('Slot is fully booked. Please choose another slot.');
//         }
//       } else {
//         // Slot does not exist, create a new slot
//         Map<String, dynamic> newSlotData = {
//           'numberOfTicketsBooked': 1,
//           'users': [userId],
//         };
//
//         // Update the document in Firestore
//         await bookingRef.update({ 'slot$selectedSlot': newSlotData });
//         print('Appointment booked successfully!');
//       }
//     }
//   }
// }
//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseAuthServices{

  FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> signUpWithEmailandPassword(String email, String password) async{
    try{
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    return null;
  }

  Future<User?> signInWithEmailandPassword(String email, String password) async{
    try{
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    return null;
  }
}
class AppointmentManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> bookAppointment(String dateString, int selectedSlot,
      String userId) async {
    // Create a document reference with the selected date
    DocumentReference bookingRef = _firestore.collection('bookings').doc(dateString);

    // Get the document snapshot for the selected date
    DocumentSnapshot dateSnapshot = await bookingRef.get();

    if (!dateSnapshot.exists) {
      // Document does not exist, create a new document
      Map<String, dynamic> initialSlots = {
        'slot$selectedSlot': {
          'numberOfTicketsBooked': 1,
          'users': [userId],
        }
      };

      // Set the document in Firestore
      await bookingRef.set(initialSlots);
      print('Appointment booked successfully!');
      return true;
    } else {
      // Document exists, get the current slot data
      Map<String, dynamic>? slotData = dateSnapshot.data() as Map<String, dynamic>?;

      // Check if the slot is available
      Map<String, dynamic>? selectedSlotData = slotData?['slot$selectedSlot'];

      if (selectedSlotData != null) {
        // Slot exists
        int count = selectedSlotData['numberOfTicketsBooked'] ?? 0;
        if (count < 3) {
          // Slot is available, update slot data with user ID
          List<dynamic> users = List.from(selectedSlotData['users']);
          users.add(userId);

          // Update slot data
          selectedSlotData['numberOfTicketsBooked'] = count + 1;
          selectedSlotData['users'] = users;

          // Update the document in Firestore
          await bookingRef.update({ 'slot$selectedSlot': selectedSlotData });
          print('Appointment booked successfully!');
          return true;
        } else {
          // Slot is fully booked
          print('Slot is fully booked. Please choose another slot.');
          return false;
        }
      } else {
        // Slot does not exist, create a new slot
        Map<String, dynamic> newSlotData = {
          'numberOfTicketsBooked': 1,
          'users': [userId],
        };

        // Update the document in Firestore
        await bookingRef.update({ 'slot$selectedSlot': newSlotData });
        print('Appointment booked successfully!');
        return true;
      }
    }
  }
}