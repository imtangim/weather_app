import 'package:flutter/material.dart';

class ForcastCard extends StatelessWidget {
  final String date;
  final IconData icon;
  final num temperature;
  final String time;
  const ForcastCard({
    super.key,
    required this.icon,
    required this.temperature,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        child: Container(
          width: 130,
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
                maxLines: 1,
              ),
              const SizedBox(height: 5),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              Icon(
                icon,
                size: 45,
              ),
              const SizedBox(height: 6),
              Text(
                "${temperature.toString()}°",
                style: const TextStyle(fontSize: 16),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
