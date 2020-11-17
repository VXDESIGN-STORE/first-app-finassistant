import 'package:first_app_finassistant/enums/currency_type.dart';

class CurrencyRate {
  CurrencyType _from;
  CurrencyType _to;
  double _value;

  CurrencyType get from => _from;

  CurrencyType get to => _to;

  double get value => _value;

  CurrencyRate(this._from, this._to, this._value);

  double convert(double source) {
    return _value * source;
  }
}
