import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/onboarding/onboarding_state.dart';
import 'onboarding_personal_data_screen.dart';

class OnboardingGoalsScreen extends StatefulWidget {
  const OnboardingGoalsScreen({super.key});

  @override
  State<OnboardingGoalsScreen> createState() => _OnboardingGoalsScreenState();
}

class _OnboardingGoalsScreenState extends State<OnboardingGoalsScreen> {
  int steps = 8000;
  int water = 6; // in cups
  int sleep = 8; // in hours
  int exercise = 30; // in minutes/day
  int weight = 70; // in kg

  @override
  void initState() {
    super.initState();

    final saved = Provider.of<OnboardingState>(context, listen: false).goals;

    if (saved.isNotEmpty) {
      steps = saved["steps"] ?? steps;
      water = saved["water"] ?? water;
      exercise = saved["exercise"] ?? exercise;
      sleep = saved["sleep"] ?? sleep;
      weight = saved["weight"] ?? weight;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final reasons = Provider.of<OnboardingState>(context).selectedReasons;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Row(
              children: [
                IconButton(
                  onPressed: () => {
                    Provider.of<OnboardingState>(context, listen: false)
                            .setGoals({
                          "steps": steps,
                          "water": water,
                          "exercise": exercise,
                          "sleep": sleep,
                          "weight": weight,
                      }),
                    Navigator.pop(context)
                    },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        _progressBar(active: true),
                        const SizedBox(width: 6),
                        _progressBar(active: true),
                        const SizedBox(width: 6),
                        _progressBar(active: false),
                        const SizedBox(width: 6),
                        _progressBar(active: false),
                      ],
                    )
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),
            // Title
            Center(
              child: Text(
                "Set Your Daily Goals",
                style: TextStyle (
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),
            // Subtitle
            Text(
              "Choose the health metrics you'd like to track and set your daily targets",
              textAlign: TextAlign.center,
              style: TextStyle (
                color: Colors.white70,
                fontSize: 20,
              ),
            ),

            // Add sliders and inputs for goals here
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _goalCard(
                    icon: Icons.directions_walk,
                    title: "Daily Step Goal",
                    value: steps,
                    unit: "",
                    onPlus: () => setState(() => steps += 500),
                    onMinus: () => setState(() => steps = (steps - 500).clamp(1000, 50000)),
                    onChanged: (v) => setState(() => steps = v.clamp(1000, 50000)),
                  ),
                  _goalCard(
                    icon: Icons.water_drop_outlined,
                    title: "Water Intake",
                    value: water,
                    unit: "cups",
                    onPlus: () => setState(() => water++),
                    onMinus: () => setState(() => water = (water - 1).clamp(1, 30)),
                    onChanged: (v) => setState(() => water = v.clamp(1, 30)),
                  ),
                  _goalCard(
                    icon: Icons.fitness_center_outlined,
                    title: "Exercise Time",
                    value: exercise,
                    unit: "min",
                    onPlus: () => setState(() => exercise += 5),
                    onMinus: () => setState(() => exercise = (exercise - 5).clamp(5, 300)),
                    onChanged: (v) => setState(() => exercise = v.clamp(5, 300)),
                  ),
                  _goalCard(
                    icon: Icons.nights_stay_outlined,
                    title: "Sleep Duration",
                    value: sleep,
                    unit: "hrs",
                    onPlus: () => setState(() => sleep++),
                    onMinus: () => setState(() {
                      sleep = (sleep-1).clamp(4, 15);
                    }),
                    onChanged: (v) => setState(() => sleep = v.clamp(4, 15)),
                  ),
                  _goalCard(
                    icon: Icons.monitor_weight_rounded,
                    title: "Weight Target",
                    value: weight,
                    unit: "kg",
                    onPlus: () => setState(() => weight++),
                    onMinus: () => setState(() {
                      weight = (weight-1).clamp(30, 300);
                    }),
                    onChanged: (v) => setState(() => weight = v.clamp(30, 300)),
                  ),

                  // Continue Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                        Provider.of<OnboardingState>(context, listen: false)
                            .setGoals({
                          "steps": steps,
                          "water": water,
                          "exercise": exercise,
                          "sleep": sleep,
                          "weight": weight,
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OnboardingPersonalDataScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
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

          ],
        )
      )
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
  
  Widget _goalCard({
  required IconData icon,
  required String title,
  required int value,
  required String unit,
  required VoidCallback onPlus,
  required VoidCallback onMinus,
  required Function(int) onChanged,
}) {
  final controller = TextEditingController(text: value.toString());

  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.08),
        width: 1.3,
      ),
    ),
    child: Row(
      children: [
        // Icon circle
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.pink[200], size: 22),
        ),

        const SizedBox(width: 16),

        // Title
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Minus button
        IconButton(
          onPressed: onMinus,
          icon: const Icon(Icons.remove, color: Colors.white70),
        ),

        // Text field for typing numbers
        SizedBox(
          width: 55,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onSubmitted: (val) {
              if (val.isNotEmpty && int.tryParse(val) != null) {
                onChanged(int.parse(val));
              } else {
                controller.text = value.toString(); // reset invalid input
              }
            },
          ),
        ),

        // Unit text
        Text(
          unit,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Plus button
        IconButton(
          onPressed: onPlus,
          icon: const Icon(Icons.add, color: Colors.white70),
        ),
      ],
    ),
  );
}
}
  