import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final List<String> measurements = ['Celsius', 'Fahrenheit', 'Kelvin'];

class MainApp extends StatelessWidget {
  
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: TemperatureConverterScreen()
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  ConverterScreenState createState() => ConverterScreenState();
}

class ConverterScreenState extends State<TemperatureConverterScreen> {
  String? from_measurement;
  String? to_measurement;
  double inputValue = 0;
  String convert_result = 'The conversion result will be here';
  TextEditingController temperature_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Temp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: temperature_controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Temperature',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('From'),
                      DropdownButton<String>(
                        value: from_measurement,
                        onChanged: (new_value) {
                          setState(() {
                            from_measurement = new_value;
                          });
                        },
                        items: measurements.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  )
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('To'),
                      DropdownButton<String>(
                        value: to_measurement,
                        onChanged: (newValue) {
                          setState(() {
                            to_measurement = newValue;
                          });
                        },
                        items: measurements.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String temperature_value = temperature_controller.text;
                if (temperature_value.isNotEmpty && from_measurement != null && to_measurement != null && from_measurement != to_measurement) {
                setState(() {
                  convert_result = ConvertTemperature(temperature_value, from_measurement, to_measurement);
                });
              }
              },
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            Text(
              convert_result,
              style: const TextStyle(fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}

String ConvertTemperature(String temperature_text, String? unit_from, String? unit_to) {
  final double temperature_controller = double.tryParse(temperature_text) ?? 0.0;
  String abreviation = "";
  double converted_value = 0.0;

  if (unit_from == 'Celsius' && unit_to == 'Fahrenheit') {
    converted_value = temperature_controller * 1.8 + 32;
    abreviation = 'ºF';
  } else if (unit_from == 'Celsius' && unit_to == 'Kelvin') {
    converted_value = temperature_controller + 273;
    abreviation = 'K';
  } else if (unit_from == 'Fahrenheit' && unit_to == 'Celsius') {
    converted_value = (temperature_controller - 32) / 1.8;
    abreviation = 'ºC';
  } else if (unit_from == 'Fahrenheit' && unit_to == 'Kelvin') {
    converted_value = (temperature_controller - 32) * 5/9 + 273;
    abreviation = 'K';
  } else if (unit_from == 'Kelvin' && unit_to == 'Celsius') {
    converted_value = temperature_controller - 273;
    abreviation = 'ºC';
  } else if (unit_from == 'Kelvin' && unit_to == 'Fahrenheit') {
    converted_value = (temperature_controller - 273) * 1.8 + 32;
    abreviation = 'ºF';
  }

  return '${converted_value.toStringAsFixed(1)} $abreviation';
}