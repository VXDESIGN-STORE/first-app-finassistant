import 'package:first_app_finassistant/components/edit_screen_state.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/screens/account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditBankAccountScreen extends StatefulWidget {
  final BankAccount bankAccount;

  const EditBankAccountScreen({this.bankAccount});

  @override
  _EditBankAccountScreenState createState() => _EditBankAccountScreenState();
}

class _EditBankAccountScreenState extends EditScreenState<EditBankAccountScreen> {
  static const String _keyPrefix = "edit_bank_account";

  final _nameController = TextEditingController();
  BankAccountType _bankAccountType;
  CurrencyType _currencyType;

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  _prepare() {
    _nameController.text = widget.bankAccount?.name?.toString();
    _bankAccountType = widget.bankAccount?.bankAccountType;
    _currencyType = widget.bankAccount?.currencyType;
  }

  @override
  void dispose() {
    _nameController.dispose();
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
              AppText.kBankNameLabel,
              style: buildTextStyleForLabel(),
            ),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              style: buildTextStyleForInput(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppText.kBankNameHint,
              ),
              controller: _nameController,
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
              AppText.kBankAccountTypeLabel,
              style: buildTextStyleForLabel(),
            ),
            InkWell(
              onTap: () => _selectAccountType(context),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bankAccountType != null
                        ? getBankAccountTypeDescription(_bankAccountType)
                        : Text(
                            AppText.kEmptyField,
                            style: buildTextStyleForInput(),
                          ),
                    FaIcon(
                      FontAwesomeIcons.wallet,
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
      if (widget.bankAccount != null) ...[
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
                AppText.kDeleteBankAccount,
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

  _selectAccountType(BuildContext context) async {
    final BankAccountType picked = await showDialog<BankAccountType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(AppText.kSelectBankAccountType),
            children: <Widget>[
              for (var type in BankAccountType.values)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, type);
                  },
                  child: getBankAccountTypeDescription(type, isLink: true),
                ),
            ],
          );
        });

    if (picked != null)
      setState(() {
        _bankAccountType = picked;
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
                  child: getCurrencyTypeDescription(type, isLink: true),
                ),
            ],
          );
        });

    if (picked != null)
      setState(() {
        _currencyType = picked;
      });
  }

  Row getBankAccountTypeDescription(BankAccountType type, {bool isLink = false}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: FaIcon(
            type.getIcon(),
            size: 24,
            color: isLink ? AppColor.kLinkColor : AppColor.kTextOnLightColor,
          ),
        ),
        Text(
          type.getName(),
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: isLink ? AppColor.kLinkColor : AppColor.kTextOnLightColor,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Text getCurrencyTypeDescription(CurrencyType type, {bool isLink = false}) {
    return Text(
      "${type.getLongName()} (${type.getSign()})",
      style: buildTextStyleForInput(isLink: isLink),
    );
  }

  @override
  void complete(BuildContext context) async {
    var errors = <String>[];
    if (_nameController.value.text?.isNotEmpty != true) {
      errors.add(AppText.kBankNameLabel);
    }
    if (_bankAccountType == null) {
      errors.add(AppText.kBankAccountTypeLabel);
    }
    if (_currencyType == null) {
      errors.add(AppText.kCurrencyRateLabel);
    }

    if (errors.isNotEmpty) {
      generateAlert(errors);
    } else {
      BankAccount bankAccount;
      setState(() {
        var name = _nameController.value.text;
        var bankAccountType = _bankAccountType;
        var currencyType = _currencyType;
        if (widget.bankAccount != null) {
          bankAccount = storageProvider.bankAccounts.firstWhere((e) => e.id == widget.bankAccount.id);
          bankAccount.update(name, bankAccountType, currencyType);
        } else {
          bankAccount = BankAccount.newItem(name, bankAccountType, currencyType);
          storageProvider.bankAccounts.add(bankAccount);
        }

        storageProvider.updateBankAccountList();
      });

      var navigator = Navigator.of(context);
      if (widget.bankAccount != null) {
        navigator.pop();
      } else {
        navigator.popAndPushNamed(AccountScreen.routeName, arguments: bankAccount);
      }
    }
  }

  void delete(BuildContext context) async {
    var confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(AppText.kBankAccountRemovalConfirmation),
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
        storageProvider.transactions.removeWhere((e) => e.bankAccountId == widget.bankAccount?.id);
        storageProvider.bankAccounts.removeWhere((e) => e.id == widget.bankAccount?.id);
        storageProvider.updateTransactionList();
        storageProvider.updateBankAccountList();
      });

      var navigator = Navigator.of(context);
      navigator.pop();
      if (navigator.canPop()) {
        navigator.pop();
      }
    }
  }
}
