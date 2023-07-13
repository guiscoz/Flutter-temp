import 'package:flutter/material.dart';
import 'package:flutter_temp/components/measurementColumn.dart';

void main() {
  runApp(const MainApp());
}

List<String> measurements = ['Celsius', 'Fahrenheit', 'Kelvin'];

class MainApp extends StatelessWidget {
  
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const TemperatureConverterScreen()
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  ConverterScreenState createState() => ConverterScreenState();
}

class ConverterScreenState extends State<TemperatureConverterScreen> {
  String? fromMeasurement;
  String? toMeasurement;
  String conversionResult = 'Conversion result';
  TextEditingController temperatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Temp', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: temperatureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Temperature',
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 64),
            Row(
              children: [
                Expanded(
                  child: MeasurementColumn(
                    label: 'From',
                    value: fromMeasurement,
                    measurements: measurements,
                    onChanged: (newValue) {
                      setState(() {
                        fromMeasurement = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MeasurementColumn(
                    label: 'To',
                    value: toMeasurement,
                    measurements: measurements,
                    onChanged: (newValue) {
                      setState(() {
                        toMeasurement = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                String temperatureValue = temperatureController.text;
                if (temperatureValue.isNotEmpty && fromMeasurement != null && toMeasurement != null && fromMeasurement != toMeasurement) {
                  setState(() {
                    conversionResult = convertTemperature(temperatureValue, fromMeasurement, toMeasurement);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
              ),
              child: const Text(
                'Convert', 
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            const SizedBox(height: 64),
            Text(
              conversionResult,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 93, 93, 93)),
            )
          ],
        ),
      ),
    );
  }
}

String convertTemperature(String temperatureText, String? unitFrom, String? unitTo) {
  final double temperatureController = double.tryParse(temperatureText) ?? 0.0;
  String abreviation = "";
  double convertedValue = 0.0;

  if (unitFrom == 'Celsius' && unitTo == 'Fahrenheit') {
    convertedValue = temperatureController * 1.8 + 32;
    abreviation = 'ºF';
  } else if (unitFrom == 'Celsius' && unitTo == 'Kelvin') {
    convertedValue = temperatureController + 273;
    abreviation = 'K';
  } else if (unitFrom == 'Fahrenheit' && unitTo == 'Celsius') {
    convertedValue = (temperatureController - 32) / 1.8;
    abreviation = 'ºC';
  } else if (unitFrom == 'Fahrenheit' && unitTo == 'Kelvin') {
    convertedValue = (temperatureController - 32) * 5/9 + 273;
    abreviation = 'K';
  } else if (unitFrom == 'Kelvin' && unitTo == 'Celsius') {
    convertedValue = temperatureController - 273;
    abreviation = 'ºC';
  } else if (unitFrom == 'Kelvin' && unitTo == 'Fahrenheit') {
    convertedValue = (temperatureController - 273) * 1.8 + 32;
    abreviation = 'ºF';
  }

  return '${convertedValue.toStringAsFixed(1)} $abreviation';
}