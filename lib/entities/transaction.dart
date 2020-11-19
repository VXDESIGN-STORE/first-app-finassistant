import 'dart:convert';

import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  String _id;
  bool _isIncome;
  String _bankAccountId;
  MoneyValue _value;
  DateTime _date;
  String _description;

  String get id => _id;

  bool get isIncome => _isIncome;

  String get bankAccountId => _bankAccountId;

  MoneyValue get value => _value;

  DateTime get date => _date;

  String get formattedDate => DateFormat.yMd().format(_date);

  String get description => _description;

  Transaction(this._id, this._isIncome, this._bankAccountId, this._value, this._date, this._description);

  Transaction.newItem(this._isIncome, this._bankAccountId, this._value, this._date, this._description) : this._id = UniqueKey().toString();

  static Transaction fromJson(String json) {
    var map = jsonDecode(json) as Map<String, dynamic>;
    var id = map.containsKey("id") ? map["id"] as String : UniqueKey().toString();
    var isIncome = map.containsKey("isIncome") ? map["isIncome"] as bool : false;
    var bankAccountId = map.containsKey("bankAccountId") ? map["bankAccountId"] as String : "";
    var value = map.containsKey("value") ? MoneyValue.fromJson(map["value"]) : MoneyValue.zero;
    var date = map.containsKey("date") ? DateFormat.yMd().parse(map["date"]) : DateTime.now();
    var description = map.containsKey("description") ? map["description"] as String : "";
    return Transaction(id, isIncome, bankAccountId, value, date, description);
  }

  String toJson() => jsonEncode({
        "id": _id,
        "isIncome": _isIncome,
        "bankAccountId": _bankAccountId,
        "value": _value.toJson(),
        "date": DateFormat.yMd().format(_date),
        "description": _description,
      });

  void update(bool isIncome, String bankAccountId, MoneyValue value, DateTime date, String description) {
    _isIncome = isIncome;
    _bankAccountId = bankAccountId;
    _value = value;
    _date = date;
    _description = description;
  }
}

extension TransactionIterable on Iterable<Transaction> {
  MoneyValue sum(CurrencyType type) {
    var result = 0.0;
    for (var transaction in this) {
      var value = transaction.value.getConvertedValue(type);
      if (transaction.isIncome) {
        result += value;
      } else {
        result -= value;
      }
    }
    return MoneyValue(result, type);
  }

  MoneyValue sumOfIncome(CurrencyType type) {
    return this.where((transaction) => transaction.isIncome).map((transaction) => transaction.value).sum(type);
  }

  MoneyValue sumOfOutcome(CurrencyType type) {
    return this.where((transaction) => !transaction.isIncome).map((transaction) => transaction.value).sum(type);
  }

  MoneyValue sumOfAccount(CurrencyType type, BankAccount account) {
    return this.where((transaction) => transaction.bankAccountId == account.id).sum(type);
  }
}
