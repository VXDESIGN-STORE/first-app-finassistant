import 'dart:convert';

import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/currency_rates.dart';
import 'package:first_app_finassistant/other/money_value_number_style.dart';

class MoneyValue {
  double _value;
  CurrencyType _type;

  double get value => _value;

  CurrencyType get type => _type;

  static final MoneyValue zero = MoneyValue(0, CurrencyType.RUR);

  MoneyValue(this._value, this._type);

  static MoneyValue fromJson(String json) {
    var map = jsonDecode(json) as Map<String, dynamic>;
    var value = map.containsKey("value") ? map["value"] as double : 0.0;
    var type = map.containsKey("type") ? CurrencyType.values[map["type"] as int] : CurrencyType.RUR;
    return MoneyValue(value, type);
  }

  String toJson() => jsonEncode({
        "value": _value,
        "type": _type.index,
      });

  double getConvertedValue(CurrencyType type) {
    double value;
    if (this._type == type) {
      value = this._value;
    } else {
      var converted = CurrencyRates.rates.firstWhere((element) => element.from == this._type && element.to == type, orElse: () => CurrencyRates.zero);
      value = converted.convert(this._value);
    }

    return value;
  }

  String getFormattedValue(CurrencyType type) {
    var value = getConvertedValue(type);
    return MoneyValueNumberStyle.currencyFormat.format(value);
  }
}

extension MoneyValueIterable on Iterable<MoneyValue> {
  MoneyValue sum(CurrencyType type) {
    var result = 0.0;
    for (var value in this) {
      result += value.getConvertedValue(type);
    }
    return MoneyValue(result, type);
  }
}
