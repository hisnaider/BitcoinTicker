import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinClass {
  late String _currentCurrency;
  final List<String> _listOfCurrency = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR'
  ];
  final Map<String, String> _listOfFlags = {
    'AUD': "🇦🇺",
    'BRL': "🇧🇷",
    'CAD': "🇨🇦",
    'CNY': "🇨🇳",
    'EUR': "🇪🇺",
    'GBP': "🇬🇧",
    'HKD': "🇭🇰",
    'IDR': "🇮🇩",
    'ILS': "🇮🇱",
    'INR': "🇮🇳",
    'JPY': "🇯🇵",
    'MXN': "🇲🇽",
    'NOK': "🇳🇴",
    'NZD': "🇳🇿",
    'PLN': "🇵🇱",
    'RON': "🇷🇴",
    'RUB': "🇷🇺",
    'SEK': "🇸🇪",
    'SGD': "🇸🇬",
    'USD': "🇺🇸",
    'ZAR': "🇿🇦",
  };

  final List<String> crypto = ["BTC", "ETH", "LTC"];

  CoinClass({required currentCurrency}) {
    _currentCurrency = currentCurrency;
  }

  void setCurrentCurrency(String currency) {
    _currentCurrency = currency;
  }

  Future<List<double>> setCryptoValues() async {
    List<double> newCryptoValue = [];
    for (String element in crypto) {
      http.Response result = await http.get(
          Uri.https(
            "rest.coinapi.io",
            "/v1/exchangerate/$element/$_currentCurrency",
          ),
          headers: {"X-CoinAPI-Key": "CHAVE DA API AQUI"});
      if (result.statusCode != 200) {
        throw result.statusCode;
      }
      var data = jsonDecode(result.body);
      newCryptoValue.add(data["rate"]);
    }
    return newCryptoValue;
  }

  String getCurrentCurrency() {
    return _currentCurrency;
  }

  List<String> getList() {
    return _listOfCurrency;
  }

  String? getFlag(flag) {
    return _listOfFlags[flag];
  }
}
