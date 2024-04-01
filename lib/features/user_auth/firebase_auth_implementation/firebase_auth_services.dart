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
        if (count < 100) {
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

