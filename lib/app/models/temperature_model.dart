class CurrencyModel {
  final String name;
  final String acronym;
  final double celsius;
  final double fahrenheit;
  final double kelvin;

  CurrencyModel({required this.name, required this.acronym,required this.celsius, required this.fahrenheit, required this.kelvin});

  static List<CurrencyModel> getCurrencies() {
    return <CurrencyModel>[
      CurrencyModel(
        name: 'Celsius',
        acronym: '° C', 
        celsius: 1.0, 
        fahrenheit: 33.8, 
        kelvin: 274.15
      ),
      CurrencyModel(
        name: 'Fahrenheit',
        acronym: '° F',  
        celsius: -17.2222, 
        fahrenheit: 1.0, 
        kelvin: 255.928
      ),
      CurrencyModel(
        name: 'Kelvin',
        acronym: 'K',  
        celsius: -272.15, 
        fahrenheit: -457.87, 
        kelvin: 1.0
      )
    ];
  }
}

/*
  Formulas
  Kelvin para Celsius
  C = K - 273

  Kelvin para Fahrenheit
  F = (K - 273) * 1.8 + 32

  Celsius para Kelvin
  K = C + 273

  Kelvin para Fahrenheit
  F = C * 1.8 + 32

  Fahrenheit para Celsius
  C = (F - 32) / 1.8

  Fahrenheit para Kelvin
  K (F - 32) * 5 / 9 + 273
*/