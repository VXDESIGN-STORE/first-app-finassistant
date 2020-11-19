import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/entities/transaction.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  static StorageProvider _storageProvider;

  CurrencyType summaryType = CurrencyType.RUR;
  List<BankAccount> _accounts = [];
  List<Transaction> _transactions = [];

  Key _currencyTypeChangeKey = generateCurrencyTypeChangeKey();
  Key _bankAccountsKey = generateBankAccountChangeKey();

  List<BankAccount> get bankAccounts => _accounts;

  List<Transaction> get transactions => _transactions;

  List<Transaction> get orderedTransactions {
    var result = <Transaction>[];
    if (transactions?.isNotEmpty == true) {
      // desc
      result = transactions.sublist(0);
      result.sort((transaction1, transaction2) => -transaction1.date.compareTo(transaction2.date));
    }
    return result;
  }

  Key get currencyTypeChangeKey => _currencyTypeChangeKey;

  Key get bankAccountsKey => _bankAccountsKey;

  StorageProvider._();

  static StorageProvider getInstance() => _storageProvider ??= new StorageProvider._();

  initData(SharedPreferences preferences) {
    summaryType = CurrencyType.values[(preferences.getInt(AppSharedKey.kActiveType) ?? 0)];
    _accounts = preferences.getStringList(AppSharedKey.kBankAccounts)?.map(BankAccount.fromJson)?.toList() ?? [];
    _transactions = preferences.getStringList(AppSharedKey.kTransactions)?.map(Transaction.fromJson)?.toList() ?? [];
  }

  static Key generateCurrencyTypeChangeKey() {
    return Key("currencyType:${DateTime.now()}");
  }

  regenerateCurrencyTypeChangeKey() {
    _currencyTypeChangeKey = generateCurrencyTypeChangeKey();
  }

  static Key generateBankAccountChangeKey() {
    return Key("bankAccount:${DateTime.now()}");
  }

  regenerateBankAccountChangeKey() {
    _bankAccountsKey = generateBankAccountChangeKey();
  }

  changeCurrencyType(CurrencyType type, Function(VoidCallback) setState) async {
    if (summaryType != type) {
      var preferences = await SharedPreferences.getInstance();
      setState(() {
        summaryType = type;
        regenerateCurrencyTypeChangeKey();
        preferences.setInt(AppSharedKey.kActiveType, summaryType.index);
      });
    }
  }

  BankAccount getBankAccount(Transaction transaction) {
    return _accounts.firstWhere((account) => account.id == transaction.bankAccountId);
  }

  updateTransactionList() async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList(AppSharedKey.kTransactions, transactions.map((e) => e.toJson()).toList());
  }

  updateBankAccountList() async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList(AppSharedKey.kBankAccounts, bankAccounts.map((e) => e.toJson()).toList());
  }
}
