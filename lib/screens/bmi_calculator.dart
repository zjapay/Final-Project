import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMICalculatorScreenState get createState => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bmiResult = '';
  String _bmiCategory = '';

  void _calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0.0;
    final double weight = double.tryParse(_weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      final double bmi = weight / ((height / 100) * (height / 100));

      String category = '';
      if (bmi < 18.5) {
        category = 'Underweight';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        category = 'Normal weight';
      } else if (bmi >= 25 && bmi < 29.9) {
        category = 'Overweight';
      } else {
        category = 'Obese';
      }

      setState(() {
        _bmiResult = 'Your BMI: ${bmi.toStringAsFixed(2)}';
        _bmiCategory = 'Category: $category';
      });
    } else {
      setState(() {
        _bmiResult = 'Please enter valid values for height and weight.';
        _bmiCategory = '';
      });
    }
  }

  void _saveBMI() {
    final bmiData = {
      'type': 'BMI',
      'value': _bmiResult,
      'category': _bmiCategory,
      'dateTime': DateTime.now(),
    };
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Progress Saved'),
        duration: Duration(seconds: 3),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, bmiData); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: "Height (cm)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.orange[300],
                  ),
                  child: const Text("Calculate BMI", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),
                if (_bmiResult.isNotEmpty)
                  Text(
                    _bmiResult,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 10),
                if (_bmiCategory.isNotEmpty)
                  Text(
                    _bmiCategory,
                    style: const TextStyle(fontSize: 20, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveBMI,
        backgroundColor: Colors.orange[300],
        child: const Icon(Icons.save),
      ),
    );
  }
}