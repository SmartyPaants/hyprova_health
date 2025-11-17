import 'package:flutter/material.dart';
import 'onboarding/onboarding_reason_screen.dart';

void main() {
  runApp(const HRBApp());
}

class HRBApp extends StatelessWidget {
  const HRBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRB App',
      theme: ThemeData(
        fontFamily: 'Inter', // simple + modern like Bearable
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const OnboardingReasonScreen(),
    );
  }
}