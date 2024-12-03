import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calorie_count.dart';
import 'bmi_calculator.dart';
import 'progress.dart';
import 'meal_planner.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> get createState => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> savedProgress = [];

  Future<void> _navigateToBMICalculator() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BMICalculatorScreen(),
      ),
    );
    if (result != null) {
      setState(() {
        savedProgress.add(result);
      });
    }
  }

  // Calorie Count
  Future<void> _navigateToCalorieCount() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CalorieCount(),
      ),
    );
    if (result != null) {
      setState(() {
        savedProgress.add(result);
      });
    }
  }

  // Progress Screen
  void _navigateToProgressScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressScreen(savedProgress: savedProgress),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Calorie Counter and BMI Calculator"),
      centerTitle: true,
      elevation: 8,
      backgroundColor: Colors.red[300],
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[100]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Your Health Tracker',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBoxButton(
                        context,
                        'Calorie Counter',
                        Icons.fastfood_rounded,
                        Colors.lightGreen[300]!,
                        _navigateToCalorieCount,
                        width: 90,
                      ),
                      const SizedBox(width: 20),
                      _buildBoxButton(
                        context,
                        'BMI Calculator',
                        Icons.calculate_rounded,
                        Colors.orange[300]!,
                        _navigateToBMICalculator,
                        width: 90,
                      ),
                      const SizedBox(width: 20),
                      _buildBoxButton(
                        context,
                        'Progress',
                        Icons.show_chart_rounded,
                        Colors.pink[200]!,
                        _navigateToProgressScreen,
                        width: 90,
                      ),
                      const SizedBox(width: 20),
                      _buildBoxButton(
                        context,
                        'Meal Planner',
                        Icons.restaurant_menu_rounded,
                        Colors.purple[200]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MealPlanner(),
                          ),
                        ),
                        width: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
Positioned(
  bottom: 16,
  left: 16,
  child: StreamBuilder<DateTime>(
    stream: Stream.periodic(
        const Duration(seconds: 1), (_) => DateTime.now()),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const SizedBox.shrink();
      }
      final DateTime currentTime = snapshot.data!;
      final String formattedTime =
          DateFormat('MM-dd-yyyy HH:mm:ss').format(currentTime);
      return Text(
        formattedTime,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    },
  ),
),
        ],
      ),
    ),
  );
}

  Widget _buildBoxButton(BuildContext context, String label, IconData icon,
      Color color, VoidCallback onPressed,
      {double width = 80}) {
    return Container(
      width: width,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: color,
          elevation: 6,
          shadowColor: Colors.grey.withOpacity(0.5),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
