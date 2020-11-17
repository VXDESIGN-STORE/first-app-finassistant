enum CurrencyType {
  RUR,
  USD,
  EUR,
}

extension CurrencyTypeExtension on CurrencyType {
  String getShortName() {
    switch (this) {
      case CurrencyType.RUR:
        return "RUB";
      case CurrencyType.USD:
        return "USD";
      case CurrencyType.EUR:
        return "EUR";
      default:
        return "";
    }
  }

  String getSign() {
    switch (this) {
      case CurrencyType.RUR:
        return "₽";
      case CurrencyType.USD:
        return "\$";
      case CurrencyType.EUR:
        return "€";
      default:
        return "";
    }
  }
}
