import 'package:flutter/material.dart';

class ForcastCard extends StatelessWidget {
  final IconData icon;
  final num temperature;
  final String time;
  const ForcastCard({
    super.key,
    required this.icon,
    required this.temperature,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              temperature.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
