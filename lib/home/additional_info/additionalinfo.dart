import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valuee;
  const AdditionalInfo(
      {super.key,
      required this.icon,
      required this.label,
      required this.valuee});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 45,
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 15),
          ),
          // const SizedBox(
          //   height: 8,
          // ),
          Text(valuee.toString(),
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
