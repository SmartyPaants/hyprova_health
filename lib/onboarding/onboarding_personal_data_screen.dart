import 'package:flutter/material.dart';

class OnboardingPersonalDataScreen extends StatefulWidget {
  const OnboardingPersonalDataScreen({super.key});

  @override
  State<OnboardingPersonalDataScreen> createState() => _OnboardingPersonalDataScreenState();
}

class _OnboardingPersonalDataScreenState extends State<OnboardingPersonalDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data'),
      ),
      body: const Center(
        child: Text('Personal Data Screen'),
      ),
    );
  }
}