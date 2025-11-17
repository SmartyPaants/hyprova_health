import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: OnboardingReasonScreen()));
}

class OnboardingReasonScreen extends StatefulWidget {
  const OnboardingReasonScreen({super.key});

  @override
  State<OnboardingReasonScreen> createState() => _OnboardingReasonScreenState();
}

class _OnboardingReasonScreenState extends State<OnboardingReasonScreen> {
  List<String> reasons = [
    'Track Health Symptoms',
    'Manage a Health Condition',
    'Lose Weight',
    'Build Healthy Habits',
    'Improve Mental Health',
    'Other',
  ];

  String? selectedReason;
  final Set<String> selectedReasons = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to Your Health Journey", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),)),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: reasons.length,
              itemBuilder: (context, index) {
                final reason = reasons[index];
                final isSelected = reason == selectedReason;
                return ListTile(
                  title: Text(reason),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value! ? reason : null;
                      });
                    },
                  ),
                  onTap: (){
                    setState(() {
                      if (isSelected) {
                        selectedReasons.remove(reason);
                      } else {
                        
                      }
                  },
                );
                  },
                );
              }
            ),
      ),
        ]
      )
    );
  }
}