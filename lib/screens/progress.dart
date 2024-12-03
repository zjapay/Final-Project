import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgressScreen extends StatefulWidget {
  final List<Map<String, dynamic>> savedProgress;

  const ProgressScreen({super.key, required this.savedProgress});

  @override
  // ignore: library_private_types_in_public_api
  _ProgressScreenState get createState => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late List<Map<String, dynamic>> progressData;
  late List<Map<String, dynamic>> filteredData;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    
    progressData = widget.savedProgress;
    filteredData = progressData;
  }

  
  void _filterByDate(DateTime date) {
    setState(() {
      filteredData = progressData
          .where((entry) =>
              (entry['dateTime'] as DateTime).day == date.day &&
              (entry['dateTime'] as DateTime).month == date.month &&
              (entry['dateTime'] as DateTime).year == date.year)
          .toList();
    });
  }

  // Show calendar for date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _filterByDate(picked);
      });
    }
  }

  // Clear history and reset data
  void _clearHistory() {
    setState(() {
      progressData.clear(); 
      filteredData = progressData; 
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
        centerTitle: true,
        backgroundColor: Colors.pink[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context), // Open date picker when pressed
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _clearHistory, // Clear history button
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Divider(),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Selected Date: ${selectedDate?.toLocal()}".split(' ')[0],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            
            Expanded(
              child: filteredData.isEmpty
                  ? const Center(child: Text("No records for the selected date."))
                  : ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        var record = filteredData[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.pink[50], 
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  '${record['type']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                
                                if (record['type'] == 'BMI')
                                  Text(
                                    'BMI: ${record['value']} kg/m²',
                                    style: const TextStyle(fontSize: 14),
                                  )
                                else if (record['type'] == 'Calories')
                                  Text(
                                    'Total Calories: ${record['totalCalories']} kcal',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                const SizedBox(height: 4),
                                // Display time
                                Text(
                                    'Time: ${DateFormat('HH:mm:ss').format(record['dateTime'].toLocal())}',
                                     style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
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
