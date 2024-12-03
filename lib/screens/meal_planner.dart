import 'package:flutter/material.dart';

class MealPlanner extends StatefulWidget {
  const MealPlanner({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MealPlannerState get createState => _MealPlannerState();
}
class _MealPlannerState extends State<MealPlanner> {
  final TextEditingController _bmiController = TextEditingController();
  String? _bmiCategory;
  Map<String, Map<String, String>> _mealPlan = {};

  void _calculateBMICategory(double bmi) {
    if (bmi < 18.5) {
      _bmiCategory = 'Underweight';
      _mealPlan = _underweightMealPlan;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      _bmiCategory = 'Normal weight';
      _mealPlan = _normalMealPlan;
    } else if (bmi >= 25 && bmi < 29.9) {
      _bmiCategory = 'Overweight';
      _mealPlan = _overweightMealPlan;
    } else {
      _bmiCategory = 'Obesity';
      _mealPlan = _obesityMealPlan;
    }
  }

  
  final Map<String, Map<String, String>> _underweightMealPlan = {
    'Monday': {'Breakfast': 'Pan de sal with peanut butter and banana', 'Lunch': 'Chicken Adobo with rice', 'Dinner': 'Sinigang na baboy (Pork Sinigang) with vegetables and rice'},
    'Tuesday': {'Breakfast': 'Oatmeal with coconut milk and sliced mango', 'Lunch': 'Torta (Filipino omelet) with rice', 'Dinner': 'Fish paksiw (stewed fish) with steamed vegetables and rice'},
    'Wednesday': {'Breakfast': 'Scrambled eggs with tomatoes and onions, served with rice', 'Lunch': 'Beef caldereta with potatoes and rice', 'Dinner': 'Laing (taro leaves in coconut milk) with rice'},
    'Thursday': {'Breakfast': 'Pandesal with cheese and a glass of milk', 'Lunch': 'Chicken inasal with atchara (pickled papaya) and rice', 'Dinner': 'Grilled tilapia with sautéed vegetables and rice'},
    'Friday': {'Breakfast': 'Fried rice with egg and hotdog', 'Lunch': 'Bicol Express (pork in coconut milk and chili) with rice', 'Dinner': 'Tinolang manok (chicken ginger stew) with rice'},
    'Saturday': {'Breakfast': 'Arroz caldo (Filipino rice porridge) with a boiled egg', 'Lunch': 'Pork steak (Bistek) with rice', 'Dinner': 'Ginisang ampalaya (bitter melon stir-fry) with rice'},
    'Sunday': {'Breakfast': 'French toast with syrup and a glass of milk', 'Lunch': 'Pork BBQ with rice', 'Dinner': 'Pinakbet (vegetable stew) with rice'},
  };

  final Map<String, Map<String, String>> _normalMealPlan = {
    'Monday': {'Breakfast': 'Oatmeal with banana and peanut butter', 'Lunch': 'Chicken tinola (ginger chicken soup) with rice', 'Dinner': 'Grilled bangus (milkfish) with vegetables and rice'},
    'Tuesday': {'Breakfast': 'Taho (silken tofu with syrup and tapioca pearls)', 'Lunch': 'Pork sinigang with kangkong (water spinach) and rice', 'Dinner': 'Ginisang monggo (mung bean soup) with rice'},
    'Wednesday': {'Breakfast': 'Longganisa with garlic rice', 'Lunch': 'Gado-Gado (Filipino-style vegetable salad) with peanut sauce', 'Dinner': 'Lechon kawali (crispy pork belly) with rice and dipping sauce'},
    'Thursday': {'Breakfast': 'Pan de sal with cheese and coffee', 'Lunch': 'Beef tapa with rice and atchara', 'Dinner': 'Baked bangus with vegetables and rice'},
    'Friday': {'Breakfast': 'Egg sandwich with mayonnaise', 'Lunch': 'Kare-kare (oxtail stew) with bagoong (shrimp paste) and rice', 'Dinner': 'Grilled chicken with ensaladang talong (eggplant salad)'},
    'Saturday': {'Breakfast': 'Suman (rice cake) with latik (coconut syrup)', 'Lunch': 'Pork adobo with rice', 'Dinner': 'Sizzling sisig with steamed rice'},
    'Sunday': {'Breakfast': 'Fried rice with scrambled egg and ham', 'Lunch': 'Laing with rice', 'Dinner': 'Caldereta with potatoes and rice'},
  };

  final Map<String, Map<String, String>> _overweightMealPlan = {
    'Monday': {'Breakfast': 'Scrambled egg with spinach and tomatoes, served with rice', 'Lunch': 'Grilled chicken with sautéed vegetables and brown rice', 'Dinner': 'Tinolang isda (fish with ginger soup) with rice'},
    'Tuesday': {'Breakfast': 'Smoothie made with papaya, banana, and water', 'Lunch': 'Grilled fish with pickled cucumber salad and rice', 'Dinner': 'Ginisang kangkong (water spinach stir-fry) with brown rice'},
    'Wednesday': {'Breakfast': 'Avocado with eggs and toast', 'Lunch': 'Chicken binakol (chicken with coconut soup) with rice', 'Dinner': 'Paksiw na tilapia with rice and vegetables'},
    'Thursday': {'Breakfast': 'Banana and peanut butter sandwich', 'Lunch': 'Veggie-packed lumpia (Filipino spring rolls) with vinegar dipping sauce', 'Dinner': 'Baked tilapia with garlic and vegetables, served with rice'},
    'Friday': {'Breakfast': 'Tofu with fruit and granola', 'Lunch': 'Pork and vegetable stir-fry with brown rice', 'Dinner': 'Pinakbet with tofu, served with brown rice'},
    'Saturday': {'Breakfast': 'Chia seed pudding with fresh fruit', 'Lunch': 'Sinigang na baboy with kangkong and rice', 'Dinner': 'Ginisang tofu with mixed vegetables and rice'},
    'Sunday': {'Breakfast': 'Green smoothie (spinach, cucumber, apple)', 'Lunch': 'Grilled chicken salad with mixed greens and vinegar dressing', 'Dinner': 'Fish and vegetable stew with rice'},
  };

  final Map<String, Map<String, String>> _obesityMealPlan = {
    'Monday': {'Breakfast': 'Fruit salad with yogurt', 'Lunch': 'Grilled bangus with steamed vegetables', 'Dinner': 'Vegetable stir-fry with tofu and brown rice'},
    'Tuesday': {'Breakfast': 'Green smoothie (spinach, avocado, banana)', 'Lunch': 'Tuna salad with mixed greens and lemon dressing', 'Dinner': 'Chicken sinigang with vegetables and brown rice'},
    'Wednesday': {'Breakfast': 'Chia seed pudding with coconut milk and fresh fruit', 'Lunch': 'Steamed fish with sautéed greens', 'Dinner': 'Baked chicken breast with mixed vegetables'},
    'Thursday': {'Breakfast': 'Oatmeal with almond milk and strawberries', 'Lunch': 'Grilled shrimp with vegetable stir-fry', 'Dinner': 'Pinakbet with tofu and brown rice'},
    'Friday': {'Breakfast': 'Scrambled eggs with spinach', 'Lunch': 'Grilled chicken with a cucumber and tomato salad', 'Dinner': 'Zucchini noodles with tomato sauce and a side salad'},
    'Saturday': {'Breakfast': 'Avocado toast with a boiled egg', 'Lunch': 'Salmon with roasted vegetables and quinoa', 'Dinner': 'Roasted cauliflower and lentil soup'},
    'Sunday': {'Breakfast': 'Fresh fruit and low-fat yogurt', 'Lunch': 'Grilled fish with sautéed vegetables', 'Dinner': 'Cauliflower rice stir-fry with tofu and vegetables'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Planner"),
        backgroundColor: Colors.purple[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _bmiController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Enter your BMI',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final bmi = double.tryParse(_bmiController.text);
                if (bmi != null) {
                  setState(() {
                    _calculateBMICategory(bmi);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid BMI")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[200],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text("Get Meal Plan", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),

            if (_bmiCategory != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _mealPlan.length,
                  itemBuilder: (context, index) {
                    String day = _mealPlan.keys.elementAt(index);
                    Map<String, String> dayMeals = _mealPlan[day]!;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      color: Colors.deepPurple[100],
                      child: ExpansionTile(
                        title: Text(
                          "$day - $_bmiCategory",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        children: dayMeals.entries.map((meal) {
                          return ListTile(
                            title: Text(
                              meal.key,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            subtitle: Text(
                              meal.value,
                              style: const TextStyle(color: Colors.black),
                            ),
                            leading: Icon(
                              meal.key == 'Breakfast'
                                  ? Icons.breakfast_dining
                                  : meal.key == 'Lunch'
                                      ? Icons.lunch_dining
                                      : Icons.dinner_dining,
                              color: Colors.black,
                            ),
                          );
                        }).toList(),
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
}
