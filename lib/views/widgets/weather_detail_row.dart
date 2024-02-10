import 'package:flutter/material.dart';

class WeatherDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const WeatherDetailRow(
      {super.key, required this.label, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null) Icon(icon, size: 30, color: Colors.grey),
          Text(
            '$label $value',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
