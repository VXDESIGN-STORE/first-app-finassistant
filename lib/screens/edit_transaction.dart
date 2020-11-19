import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/edit_screen_state.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/entities/transaction.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/decimal_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EditTransactionScreen extends StatefulWidget {
  final Transaction transaction;
  final BankAccount bankAccount;

  const EditTransactionScreen({this.transaction, this.bankAccount});

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends EditScreenState<EditTransactionScreen> {
  static const String _keyPrefix = "edit_transaction";

  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();
  BankAccount _bankAccount;
  CurrencyType _currencyType;
  DateTime _date;

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  _prepare() {
    if (widget.transaction?.isIncome == true) {
      _valueController.text = widget.transaction.value?.value?.toString();
    } else if (widget.transaction?.isIncome == false) {
      _valueController.text = (-widget.transaction.value?.value).toString();
    }
    _descriptionController.text = widget.transaction?.description;
    if (widget.transaction != null) {
      _bankAccount = storageProvider.getBankAccount(widget.transaction);
    } else if (widget.bankAccount != null) {
      _bankAccount = widget.bankAccount;
    }
    _currencyType = widget.transaction?.value?.type ?? _bankAccount?.currencyType;
    _date = widget.transaction?.date;
  }

  @override
  void dispose() {
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  String get keyPrefix => _keyPrefix;

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.only(top: 25, bottom: 12.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.kBankAccountLabel,
              style: buildTextStyleForLabel(),
            ),
            InkWell(
              onTap: () => _selectBankAccount(context),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bankAccount != null
                        ? getBankAccountDescription(context, _bankAccount)
                        : Text(
                            AppText.kEmptyField,
                            style: buildTextStyleForInput(),
                          ),
                    FaIcon(
                      FontAwesomeIcons.moneyCheck,
                      size: 24,
                      color: AppColor.kLinkColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.kValueLabel,
              style: buildTextStyleForLabel(),
            ),
            TextField(
              inputFormatters: [
                DecimalTextInputFormatter(),
              ],
              style: buildTextStyleForInput(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppText.kValueHint,
              ),
              controller: _valueController,
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.kCurrencyRateLabel,
              style: buildTextStyleForLabel(),
            ),
            InkWell(
              onTap: () => _selectCurrencyType(context),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currencyType != null
                        ? getCurrencyTypeDescription(_currencyType)
                        : Text(
                            AppText.kEmptyField,
                            style: buildTextStyleForInput(),
                          ),
                    FaIcon(
                      FontAwesomeIcons.moneyBillAlt,
                      size: 24,
                      color: AppColor.kLinkColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.kDateLabel,
              style: buildTextStyleForLabel(),
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _date != null ? DateFormat.yMd().format(_date) : AppText.kEmptyField,
                      style: buildTextStyleForInput(),
                    ),
                    FaIcon(
                      FontAwesomeIcons.calendar,
                      size: 24,
                      color: AppColor.kLinkColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.5, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.kDescriptionLabel,
              style: buildTextStyleForLabel(),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: buildTextStyleForInput(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppText.kDescriptionHint,
              ),
              controller: _descriptionController,
            ),
          ],
        ),
      ),
      if (widget.transaction != null) ...[
        Padding(
          padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 49,
            decoration: BoxDecoration(
              color: AppColor.kTextOnLightColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.5, bottom: 25, right: 15),
          child: Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => delete(context),
              child: Text(
                AppText.kDeleteTransaction,
                style: TextStyle(
                  color: AppColor.kLinkColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    ];
  }

  Row getBankAccountDescription(BuildContext context, BankAccount account) {
    return Row(
      children: [

        SelectionBankAccountRow(
          context,
          account,
        ),
      ],
    );
  }

  _selectBankAccount(BuildContext context) async {
    final BankAccount picked = await showDialog<BankAccount>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(AppText.kSelectBankAccount),
            children: <Widget>[
              for (var account in storageProvider.bankAccounts)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, account);
                  },
                  child: getBankAccountDescription(context, account),
                ),
            ],
          );
        });

    if (picked != null)
      setState(() {
        _bankAccount = picked;
      });
  }

  _selectCurrencyType(BuildContext context) async {
    final CurrencyType picked = await showDialog<CurrencyType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(AppText.kSelectCurrencyRate),
            children: <Widget>[
              for (var type in CurrencyType.values)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, type);
                  },
                  child: getCurrencyTypeDescription(type),
                ),
            ],
          );
        });

    if (picked != null)
      setState(() {
        _currencyType = picked;
      });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.kBackgroundActiveElementColor),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != _date)
      setState(() {
        _date = picked;
      });
  }

  Text getCurrencyTypeDescription(CurrencyType type) {
    return Text(
      "${type.getLongName()} (${type.getSign()})",
      style: buildTextStyleForInput(),
    );
  }

  @override
  void complete(BuildContext context) async {
    var errors = <String>[];
    if (_bankAccount == null) {
      errors.add(AppText.kBankAccountLabel);
    }
    if (_valueController.value.text?.isNotEmpty != true) {
      errors.add(AppText.kValueLabel);
    } else {
      var result = double.parse(_valueController.value.text);
      if (result > -0.00009 && result < 0.00009) {
        errors.add(AppText.kValueLabel);
      }
    }
    if (_currencyType == null) {
      errors.add(AppText.kCurrencyRateLabel);
    }
    if (_date == null) {
      errors.add(AppText.kDateLabel);
    }

    if (errors.isNotEmpty) {
      generateAlert(errors);
    } else {
      setState(() {
        var value = double.parse(_valueController.value.text);
        var isIncome = !value.isNegative;
        var bankAccountId = _bankAccount.id;
        var moneyValue = MoneyValue(value.abs(), _currencyType);
        var description = _descriptionController.value.text;
        if (widget.transaction != null) {
          var transaction = storageProvider.transactions.firstWhere((e) => e.id == widget.transaction.id);
          transaction.update(isIncome, bankAccountId, moneyValue, _date, description);
        } else {
          var transaction = Transaction.newItem(isIncome, bankAccountId, moneyValue, _date, description);
          storageProvider.transactions.add(transaction);
        }

        storageProvider.updateTransactionList();
      });

      Navigator.pop(context);
    }
  }

  void delete(BuildContext context) async {
    var confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(AppText.kTransactionRemovalConfirmation),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    "Cancel",
                    style: buildStyleForAlert(),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    "OK",
                    style: buildStyleForAlert(),
                  )),
            ],
          );
        });

    if (confirmed) {
      setState(() {
        storageProvider.transactions.removeWhere((e) => e.id == widget.transaction?.id);
        storageProvider.updateTransactionList();
      });

      Navigator.pop(context);
    }
  }
}
