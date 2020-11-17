import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BankAccountRow extends Row {
  BankAccountRow(BankAccount account) : super(
    children: [
      Padding(
        padding: EdgeInsets.only(right: 10),
        child: FaIcon(
          getIcon(account),
          size: 24,
          color: AppColor.kTextOnLightColor,
        ),
      ),
      Text(
        account.name,
        style: TextStyle(
          color: AppColor.kTextOnLightColor,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );

  static IconData getIcon(BankAccount account) {
    if (account.type == BankAccountType.CARD) return FontAwesomeIcons.creditCard;
    if (account.type == BankAccountType.DEPOSIT) return FontAwesomeIcons.university;
    return FontAwesomeIcons.questionCircle;
  }
}