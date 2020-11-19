import 'package:first_app_finassistant/components/edit_screen_state.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditBankAccountScreen extends StatefulWidget {
  final BankAccount account;

  const EditBankAccountScreen({this.account});

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
    _nameController.text = widget.account?.name?.toString();
    _bankAccountType = widget.account?.bankAccountType;
    _currencyType = widget.account?.currencyType;
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
              "Name",
              style: buildTextStyleForLabel(),
            ),
            TextField(
              style: buildTextStyleForInput(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a name',
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
              "Account Type",
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
                            "—",
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
              "Account Rate",
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
                            "—",
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
      if (widget.account != null) ...[
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
                "Delete This Bank Account?",
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
            title: const Text('Select an account type'),
            children: <Widget>[
              for (var type in BankAccountType.values)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, type);
                  },
                  child: getBankAccountTypeDescription(type),
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
            title: const Text('Select an account rate'),
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

  Row getBankAccountTypeDescription(BankAccountType type) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: FaIcon(
            type.getIcon(),
            size: 24,
            color: AppColor.kTextOnLightColor,
          ),
        ),
        Text(
          type.getName(),
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: AppColor.kTextOnLightColor,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Text getCurrencyTypeDescription(CurrencyType type) {
    return Text(
      "${type.getLongName()} (${type.getSign()})",
      style: buildTextStyleForInput(),
    );
  }
}
