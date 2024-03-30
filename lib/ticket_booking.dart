import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:haxplore//features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class TicketSlot {
  final int slotNumber;
  final bool isAvailable;

  TicketSlot({required this.slotNumber, required this.isAvailable});
}

// class TicketBooking{
//   final CollectionReference bookingsCollection = FirebaseFirestore.instance.collection(('bookings'));
//
//   Future<void> bookTicket(User user, DateTime date, int slot) async {
//
//     // Check if the slot is available
//     bool isSlotAvailable = await checkSlotAvailability(date, slot);
//     if (!isSlotAvailable) {
//       throw Exception('Slot $slot is already full.');
//     }
//
//     // Add the booking to Firestore
//     await bookingsCollection.add({
//       'userId': user.uid,
//       'date': date,
//       'slot': slot,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }


// Future<bool> checkSlotAvailability(DateTime date, int slot) async {
//   final CollectionReference bookingsCollection = FirebaseFirestore.instance.collection(('bookings'));
//
//   QuerySnapshot bookingsSnapshot = await bookingsCollection
//       .where('date', isEqualTo: date)
//       .where('slot', isEqualTo: slot)
//       .get();
//
//   int numBookings = bookingsSnapshot.docs.length;
//   return numBookings < 50;
// }


class TicketBookingWidget extends StatefulWidget {
  @override
  _TicketBookingWidgetState createState() => _TicketBookingWidgetState();
}

class _TicketBookingWidgetState extends State<TicketBookingWidget> {
  final TicketBooking _ticketBooking = TicketBooking(); // Initialize TicketBooking instance
  DateTime _selectedDate = DateTime.now();
  List<TicketSlot> _slots = [];

  @override
  void initState() {
    super.initState();
    _loadSlotsForDate(_selectedDate);
  }

  Future<void> _loadSlotsForDate(DateTime date) async {
    // Assuming slot availability data is stored in Firestore, fetch slots for the selected date
    List<TicketSlot> slots = await _ticketBooking.getSlotsForDate(date);
    setState(() {
      _slots = slots;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Booking'),
      ),
      body: Column(
        children: [
          // Date picker
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 15)),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                });
                await _loadSlotsForDate(_selectedDate);
              }
            },
            child: Text('Select Date: ${_selectedDate.toString().substring(0, 10)}'),
          ),
          // Slots list
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _slots.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Slot ${_slots[index].slotNumber}'),
                  subtitle: Text(_slots[index].isAvailable ? 'Available' : 'Booked'),
                  onTap: () {
                    // Handle slot selection, e.g., book the slot
                    // You can call _ticketBooking.bookTicket() here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TicketBooking {
  final CollectionReference bookingsCollection =
  FirebaseFirestore.instance.collection('bookings');
  Future<List<TicketSlot>> getSlotsForDate(DateTime date) async {
    // Implement logic to fetch available slots for the given date from Firestore
    // For simplicity, returning a hardcoded list of slots

    return [
      TicketSlot(slotNumber: 1, isAvailable: true),
      TicketSlot(slotNumber: 2, isAvailable: true),
      TicketSlot(slotNumber: 3, isAvailable: false), // Example: Slot 3 is booked
    ];
  }
  // Method to book a ticket
  Future<void> bookTicket(String userId, DateTime date, int slot) async {
    // Calculate the booking end date (15 days from the current date)
    DateTime bookingEndDate = DateTime.now().add(Duration(days: 15));

    // Check if the booking date is within the allowed range
    if (date.isBefore(DateTime.now()) || date.isAfter(bookingEndDate)) {
      throw Exception('Booking date is not within the allowed range.');
    }

    // Check if the slot is valid (e.g., between 1 and 3)
    if (slot < 1 || slot > 3) {
      throw Exception('Invalid slot number.');
    }

    // Check if the slot is available for the given date
    bool isSlotAvailable = await checkSlotAvailability(date, slot);
    if (!isSlotAvailable) {
      throw Exception('Slot $slot is not available for $date.');
    }

    // Add the booking to Firestore
    await bookingsCollection.add({
      'userId': userId,
      'date': date,
      'slot': slot,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Method to check slot availability for a given date and slot
  Future<bool> checkSlotAvailability(DateTime date, int slot) async {
    QuerySnapshot bookingsSnapshot = await bookingsCollection
        .where('date', isEqualTo: date)
        .where('slot', isEqualTo: slot)
        .get();

    return bookingsSnapshot.docs.isEmpty;
  }

  // Method to progress to the next day
  Future<void> progressToNextDay() async {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the next day
    DateTime nextDay = currentDate.add(Duration(days: 1));

    // Update the booking slots for the next day
    // You can implement your logic here to update the slots in Firestore
    // For example, move bookings from slot 3 of currentDate to slot 1 of nextDay

    // Update the current date in Firestore or any other necessary actions
    // This is just an example; you should implement your logic based on your requirements
  }
}
