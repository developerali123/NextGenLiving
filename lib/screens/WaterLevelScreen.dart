import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/widgets/appbar.dart';

class WaterLevelScreen extends StatefulWidget {
  const WaterLevelScreen({super.key});

  @override
  State<WaterLevelScreen> createState() => _WaterLevelScreenState();
}

class _WaterLevelScreenState extends State<WaterLevelScreen> {
  final ref = FirebaseDatabase.instance.ref('WaterLevel');
  double waterlevel = 0;

  @override
  void initState() {
    super.initState();
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      if (data != null && data is Map<String, dynamic>) {
        final water = data['WaterLevel'];
        if (water != null) {
          setState(() {
            waterlevel = water;
          });
          print('Water Level: $water');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = waterlevel / 1000 * 100;
    print(percentage);
    return Scaffold(
      appBar: const AppBarComp(),
      body: Center(
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.red, // Color of the tank
            border: Border.all(
              color: Colors.blue, // Color of the tank border
              width: 5,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 0,
                child: Container(
                  color: Colors.blue, // Color of the water
                  height: 300 * percentage / 100, // Height of the water level
                ),
              ),
              Center(
                child: Text(
                  '${percentage.toStringAsFixed(0)}%', // Water level percentage
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
