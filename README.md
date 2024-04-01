# Haxplore'24

*Temple Ticketing System*

Welcome to the Temple Ticketing System! This Flutter project aims to provide users with a convenient platform to register, login, and book tickets for temple visits. Users can easily check ticket availability for their desired date and book tickets seamlessly. 

## Features

- *User Registration and Login*: Users can create an account and log in securely to access the ticket booking system. Authentication is done using Firebase.
- *Ticket Availability Check*: Users can check the availability of tickets for any particular date of their choice. Database is managed using Firebase Firestore.
- *Ticket Booking*: Once available, users can book tickets for their desired date. Multiple tickets can be booked by a user. Database is managed using Firebase 
 Firestore.
- *QR Code Generation*: Upon successful booking, a QR code is generated as a ticket for the user.
- *Admin QR Scanner*: Admin login opens a separate UI, which consists of a QR scanner of whihc on scanning our generated QR, gives a popup with the UserID and the date and time of the slot which the user has booked, thus verifying the booking.
- *Booking Limit*: Users can book tickets for up to 2 months from the current date.
For each slot there are 100 available tickets.

## Getting Started

To get started with the Temple Ticketing System, follow these steps:

1. Clone this repository to your local machine.
2. Ensure you have Flutter and Dart installed on your machine.
3. Open the project in your preferred Flutter development environment (e.g., Android Studio, VS Code).
4. Run flutter pub get to install the project dependencies.
5. Run the project on your desired emulator or physical device.

## Usage

1. *Registration and Login*:
   - Create a new account using the registration feature.
   - Log in using your credentials to access the ticket booking system.

2. *Checking Ticket Availability*:
   - After logging in, navigate to the ticket booking section.
   - with every slot time, the number of tickets available are shown.
 3. *Booking Tickets*:
   - If tickets are available for the selected date, proceed to book them.
 4. *QR Code Generation*:
   - Upon successful booking, a QR code will be generated as your ticket.
   - Present this QR code at the temple entrance for verification.
5.  *Admin QR Scanner*:
   - Admin login opens a separate UI
   - It consists of a QR scanner of which on scanning our generated QR, gives a popup with the UserID and the date and time of the slot which the user has booked,       thus verifying the booking.
5. *Booking Limit*:
   - Users can book tickets for up to 2 months from the current date.

## Contributing

Contributions to the Temple Ticketing System are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request on GitHub.


## Acknowledgements
project contributed by
            https://github.com/themanya1112
            https://github.com/nandini11509
            https://github.com/dwsds

- Special thanks to the Flutter and Dart communities for their invaluable contributions to open-source software development.
- QR code generation functionality is powered by the [qr_flutter](https://pub.dev/packages/qr_flutter) package.


## Contact

For any inquiries or support, please contact 
[divya.student.cse22@iitbhu.ac.in]
[manya.gupta.cse22@iitbhu.ac.in]
[sharma.nandini.cse22@iitbhu.ac.in]

Thank you for using the Temple Ticketing System! Enjoy your temple visits with ease.
