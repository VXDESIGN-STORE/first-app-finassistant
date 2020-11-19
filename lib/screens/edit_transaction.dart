import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/edit_screen_state.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
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
  DateTime _selectedDate;

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
    _selectedDate = widget.transaction?.date;
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
              "Bank Account",
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
                            "—",
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
              "Value",
              style: buildTextStyleForLabel(),
            ),
            TextField(
              inputFormatters: [
                DecimalTextInputFormatter(),
              ],
              style: buildTextStyleForInput(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a value',
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
              "Date",
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
                      _selectedDate != null ? DateFormat.yMd().format(_selectedDate) : "—",
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
              "Description",
              style: buildTextStyleForLabel(),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: buildTextStyleForInput(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a description',
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
              onPressed: () {},
              child: Text(
                "Delete This Change?",
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
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            "${account.currencyType.getSign()}",
            style: buildTextStyleForInput(),
          ),
        ),
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
            title: const Text('Select a bank account'),
            children: <Widget>[
              for (var account in storageProvider.accounts)
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
}
