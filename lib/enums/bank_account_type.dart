import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum BankAccountType {
  UNDEFINED,
  CARD,
  DEPOSIT,
}

extension BankAccountTypeExtension on BankAccountType {
  String getName() {
    switch (this) {
      case BankAccountType.CARD:
        return "Card";
      case BankAccountType.DEPOSIT:
        return "Deposit";
      default:
        return "Undefined";
    }
  }

  IconData getIcon() {
    switch (this) {
      case BankAccountType.CARD:
        return FontAwesomeIcons.creditCard;
      case BankAccountType.DEPOSIT:
        return FontAwesomeIcons.university;
      default:
        return FontAwesomeIcons.questionCircle;
    }
  }
}
