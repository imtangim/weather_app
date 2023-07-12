import 'package:flutter/material.dart';

class ForcastCard extends StatelessWidget {
  const ForcastCard({super.key});

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
        child: const Column(
          children: [
            Text(
              "Time",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Icon(
              Icons.cloud,
              size: 40,
            ),
            SizedBox(height: 8),
            Text(
              "301.15",
            ),
          ],
        ),
      ),
    );
  }
}
