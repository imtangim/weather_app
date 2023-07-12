import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final num valuee;
  const AdditionalInfo(
      {super.key,
      required this.icon,
      required this.label,
      required this.valuee});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        Text(valuee.toString(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
      ],
    );
  }
}
