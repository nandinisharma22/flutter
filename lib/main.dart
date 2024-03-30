import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haxplore/features/app/splash_screen/splash_screen.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/booking_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/home_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/login_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/delete.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/signup_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/success_booked.dart';
import 'package:haxplore/ticket_booking.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/spl': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),

        '/login': (context) => LoginPage(),
        //'/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/delete': (context) => DeleteAccount(),
        // '/ticket':(context) => TicketBooking(),
        '/booking_page': (context) => BookingPage(user: ModalRoute.of(context)!.settings.arguments as User),
        '/success_booked': (context) => AppointmentBooked(),
        '/': (context) => SignUpPage(), // Route to TicketBookingPage widget
      },
    );
  }
}