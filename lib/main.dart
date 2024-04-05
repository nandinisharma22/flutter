import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haxplore/features/user_auth/presentation/admin/admin_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/booking_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/home_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/login_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/delete.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/qr_gen.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/signup_page.dart';
import 'package:haxplore/features/user_auth/presentation/pages/screens/success_booked.dart';
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
      navigatorKey: navigatorKey, // Assigning the navigatorKey to the MaterialApp
      initialRoute: '/', // Initial route is SignUpPage
      routes: {
        '/login': (context) => LoginPage(),
        '/admin': (context) => AdminPage(),
        '/home': (context) => HomePage(),
        // '/': (context) => QRView(
        //   userId: "123",
        //   date: "11.4.23",
        //   slot: "slot1200",
        // ),

        '/delete': (context) => DeleteAccount(),
        '/booking_page': (context) => BookingPage(user: ModalRoute.of(context)!.settings.arguments as User),
        // '/success_booked': (context) => AppointmentBooked(),
        '/': (context) => SignUpPage(), // Default route is SignUpPage
      },
    );
  }
}