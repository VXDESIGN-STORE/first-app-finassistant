import 'dart:convert';

import 'package:first_app_finassistant/entities/currency_rate.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:http/http.dart' as http;

class CurrencyRates {
  static final CurrencyRate zero = CurrencyRate(null, null, 0);
  static List<CurrencyRate> _rates;

  static List<CurrencyRate> get rates => _rates;

  static loadRates() async {
    var rates = <CurrencyRate>[];

    var client = http.Client();
    try {
      for (var type in CurrencyType.values) {
        var other = CurrencyType.values.where((another) => another != type);
        var query = "https://api.exchangeratesapi.io/latest?base=${type.getShortName()}&symbols=${other.map((e) => e.getShortName()).join(",")}";
        var response = await client.get(query);
        Map<String, dynamic> map = jsonDecode(response.body);

        if (map["base"] == type.getShortName()) {
          other.forEach((element) {
            var rate = map["rates"][element.getShortName()] as double;
            rates.add(CurrencyRate(type, element, rate));
          });
        }
      }
    } catch (e) {
      rates = [];
    } finally {
      client.close();
    }

    _rates = rates;
  }
}
