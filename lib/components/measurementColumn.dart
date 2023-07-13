import 'package:flutter/material.dart';

class MeasurementColumn extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> measurements;
  final void Function(String?) onChanged;

  const MeasurementColumn({
    super.key, 
    required this.label,
    required this.value,
    required this.measurements,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 239, 239),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: measurements.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 20)),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}