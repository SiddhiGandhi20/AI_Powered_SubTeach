import 'package:flutter/material.dart';
import '../widgets/splash_screen.dart'; // Import the SplashScreen file

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color
      ),
      home: SplashScreen(), // Set SplashScreen as the initial screen
    );
  }
}
