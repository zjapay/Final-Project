import 'package:flutter/material.dart';

class CalorieCount extends StatefulWidget {
  const CalorieCount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalorieCountState get createState => _CalorieCountState();
}
class _CalorieCountState extends State<CalorieCount> {
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  double totalCalories = 0.0;

  void _calculateCalories() {
    final double protein = double.tryParse(proteinController.text) ?? 0.0;
    final double carbs = double.tryParse(carbController.text) ?? 0.0;
    final double fat = double.tryParse(fatController.text) ?? 0.0;

    setState(() {
      totalCalories = (protein * 4) + (carbs * 4) + (fat * 9);
    });
  }

  void _saveCalories() {
  final calorieData = {
    'type': 'Calories',
    'protein': proteinController.text,
    'carbs': carbController.text,
    'fats': fatController.text,
    'totalCalories': totalCalories.toStringAsFixed(2),
    'dateTime': DateTime.now(),
  };

  // "Progress Saved"
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Progress Saved'),
      duration: Duration(seconds: 3),
    ),
  );

  Future.delayed(const Duration(seconds: 3), () {
    // ignore: use_build_context_synchronously
    Navigator.pop(context, calorieData); // Back to ProgressScreen
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Calorie Intake Calculator'),
      centerTitle: true,
      backgroundColor: Colors.green[300],
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[100]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Center( 
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              const Text(
                'Enter your intake for each macronutrient:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildTextField(proteinController, 'Protein (grams)'),
              const SizedBox(height: 16),
              _buildTextField(carbController, 'Carbohydrates (grams)'),
              const SizedBox(height: 16),
              _buildTextField(fatController, 'Fats (grams)'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateCalories,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.lightGreen[300],
                ),
                child: const Text('Calculate Total Calories', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              if (totalCalories > 0)
                Text(
                  'Total Calories: ${totalCalories.toStringAsFixed(2)} kcal',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _saveCalories,
      backgroundColor: Colors.green[300],
      child: const Icon(Icons.save),
    ),
  );
}

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}

