import 'package:flutter/material.dart';
import 'onboarding_goals_screen.dart';
import 'package:provider/provider.dart';
import '../state/onboarding/onboarding_state.dart';

class OnboardingReasonScreen extends StatefulWidget {
  const OnboardingReasonScreen({super.key});

  @override
  State<OnboardingReasonScreen> createState() => _OnboardingReasonScreenState();
}

class _OnboardingReasonScreenState extends State<OnboardingReasonScreen> {
  final List<Map<String, dynamic>> reasons = [
    {
      "icon": Icons.favorite_border,
      "title": "Improve my overall health",
      "subtitle": "Feel better, have more energy, and live healthier",
    },
    {
      "icon": Icons.monitor_heart_outlined,
      "title": "Track health symptoms",
      "subtitle":
          "Monitor and understand patterns in my symptoms",
    },
    {
      "icon": Icons.medical_services_outlined,
      "title": "Manage a health condition",
      "subtitle":
          "Better manage a chronic condition or health issue",
    },
    {
      "icon": Icons.scale_outlined,
      "title": "Lose weight",
      "subtitle":
          "Support my weight loss journey in a healthier way",
    },
    {
      "icon": Icons.self_improvement,
      "title": "Improve my mental wellbeing",
      "subtitle": "Reduce stress, improve mood, and support my emotional health",
    },
    {
      "icon": Icons.eco_outlined,
      "title": "Build healthy habits",
      "subtitle": "Develop consistent routines that improve long-term health and lifestyle",
    },
  ];
  
  final Set<int> selectedReasons = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row (
                children: [
                  _progressBar(active: true),
                  const SizedBox(width: 6),
                  _progressBar(),
                  const SizedBox(width: 6),
                  _progressBar(),
                  const SizedBox(width: 6),
                  _progressBar(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.pink[200],
                shape: BoxShape.circle,
              ),
              child: const Icon (
                Icons.favorite_outline,
                color: Colors.pinkAccent,
                size: 40,
              ),
            ),

            const SizedBox(height: 20),
            // Title
            Text (
              "Welcome to you Health Journey",
              textAlign: TextAlign.center,
              style: TextStyle (
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            // Subtitle
            Text(
              "What motivated you to start tracking your health?",
              textAlign: TextAlign.center,
              style: TextStyle (
                color: Colors.white70,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            Text (
              "✨ Select all that apply ✨",
              style: TextStyle (
                color: Colors.orange[300],
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),
            // Reasons List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: reasons.length,
                itemBuilder: (context, index) {
                  final item = reasons[index];
                  final isSelected = selectedReasons.contains(index);
                  return Card(
                    color: isSelected ? Colors.white10 : Colors.transparent,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(item['icon'], color: Colors.pink[200]),
                      title: Text(
                        item['title'],
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        item['subtitle'],
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      trailing: Checkbox(
                        value: isSelected,
                        activeColor: Colors.pink[300],
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              selectedReasons.add(index);
                            } else {
                              selectedReasons.remove(index);
                            }
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedReasons.remove(index);
                          } else {
                            selectedReasons.add(index);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedReasons.isEmpty 
                    ? null 
                    : () {
                      final selectedHeadings = selectedReasons.map((index) {
                        return reasons[index]["title"];
                      }).toList();
                      Provider.of<OnboardingState>(context, listen: false)
                        .setSelectedReasons(selectedHeadings);
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OnboardingGoalsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedReasons.isEmpty
                        ? Colors.grey.shade700
                        : Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _progressBar({bool active = false}) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 4,
        decoration: BoxDecoration(
          color: active ? Colors.pinkAccent : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}