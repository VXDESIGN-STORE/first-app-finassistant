import 'dart:convert';

import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:flutter/material.dart';

class BankAccount {
  String _id;
  String _name;
  BankAccountType _bankAccountType;
  CurrencyType _currencyType;

  BankAccount(this._id, this._name, this._bankAccountType, this._currencyType);

  BankAccount.newItem(this._name, this._bankAccountType, this._currencyType) : this._id = UniqueKey().toString();

  String get id => _id;

  String get name => _name;

  BankAccountType get bankAccountType => _bankAccountType;

  CurrencyType get currencyType => _currencyType;

  static BankAccount fromJson(String json) {
    var map = jsonDecode(json) as Map<String, dynamic>;
    var id = map.containsKey("id") ? map["id"] as String : UniqueKey().toString();
    var name = map.containsKey("name") ? map["name"] as String : "";
    var bankAccountType = map.containsKey("bankAccountType") ? BankAccountType.values[map["bankAccountType"] as int] : BankAccountType.CARD;
    var currencyType = map.containsKey("currencyType") ? CurrencyType.values[map["currencyType"] as int] : CurrencyType.RUR;
    return BankAccount(id, name, bankAccountType, currencyType);
  }

  String toJson() => jsonEncode({
        "id": _id,
        "name": _name,
        "bankAccountType": _bankAccountType.index,
        "currencyType": _currencyType.index,
      });

  void update(String name, BankAccountType bankAccountType, CurrencyType currencyType) {
    _name = name;
    _bankAccountType = bankAccountType;
    _currencyType = currencyType;
  }
}
