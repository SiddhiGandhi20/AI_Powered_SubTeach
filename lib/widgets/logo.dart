import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.account_circle,
      size: 120,
      color: Colors.blueAccent,
    );
  }
}
