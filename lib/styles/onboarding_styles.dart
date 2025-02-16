import 'package:flutter/material.dart';

class OnboardingStyles {
  static const Color primaryColor = Color(0xFF246BFD);
  static const Color buttonTextColor = Colors.white;

  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subHeaderTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  static BoxDecoration roleButtonDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey, width: 0.3),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
  );

  static const BoxDecoration iconBoxDecoration = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
}
