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

  Future<void> bookAppointment(String dateString, int selectedSlot,
      String userId) async {


    // Create a document reference with the selected date
    DocumentReference bookingRef = _firestore.collection('bookings').doc(
        dateString);

    // Check if the document for the selected date exists
    DocumentSnapshot dateSnapshot = await bookingRef.get();

    if (!dateSnapshot.exists) {
      // Document does not exist, create a new document
      Map<String, dynamic> initialSlots = {'users': [userId]};
      initialSlots['slot$selectedSlot'] = 1; // Set the selected slot to 1

      // Set the document in Firestore
      await bookingRef.set(initialSlots);
      print('Appointment booked successfully!');
    } else {
      // Document exists, get the current slot data
      Map<String, dynamic>? slotData = dateSnapshot.data() as Map<
          String,
          dynamic>?;

      // Check if the slot is available
      int count = slotData?['slot$selectedSlot'] ?? 0;
      if (count < 3) {
        // Slot is available, update slot data with user ID
        if (!slotData!.containsKey('users')) {
          slotData['users'] = [userId];
        } else {
          List<dynamic> users = List.from(slotData['users']);
          users.add(userId);
          slotData['users'] = users;
        }
        slotData['slot$selectedSlot'] = count + 1;

        // Update the document in Firestore
        await bookingRef.set(slotData);
        print('Appointment booked successfully!');
      } else {
        // Slot is fully booked
        print('Slot is fully booked. Please choose another slot.');
      }
    }
  }
}

