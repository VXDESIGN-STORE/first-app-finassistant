import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditBankAccount extends StatefulWidget {
  @override
  _EditBankAccountState createState() => _EditBankAccountState();
}

class _EditBankAccountState extends State<EditBankAccount> {
  static const String _keyPrefix = "edit_account";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBackgroundSummaryElementColor,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 54, left: 12),
          child: IconButton(
            key: Key("$_keyPrefix:button"),
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 24,
              color: AppColor.kLinkColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
