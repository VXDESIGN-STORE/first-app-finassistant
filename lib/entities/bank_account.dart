import 'dart:convert';

import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:flutter/material.dart';

class BankAccount {
  String _id;
  String _name;
  BankAccountType _type;
  MoneyValue _value;

  BankAccount(this._id, this._name, this._type, this._value);

  BankAccount.newItem(this._name, this._type, this._value) : this._id = UniqueKey().toString();

  String get id => _id;

  String get name => _name;

  BankAccountType get type => _type;

  MoneyValue get value => _value;

  static BankAccount fromJson(String json) {
    var map = jsonDecode(json) as Map<String, dynamic>;
    var id = map.containsKey("id") ? map["id"] as String : UniqueKey().toString();
    var name = map.containsKey("name") ? map["name"] as String : "";
    var type = map.containsKey("type") ? map["type"] as BankAccountType : BankAccountType.CARD;
    var value = map.containsKey("value") ? MoneyValue.fromJson(map["value"]) : MoneyValue.zero;
    return BankAccount(id, name, type, value);
  }

  String toJson() => jsonEncode({
        "id": _id,
        "name": _name,
        "type": _type,
        "value": _value.toJson(),
      });
}
