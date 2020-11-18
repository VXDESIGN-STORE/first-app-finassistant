import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BankAccountRow extends Row {
  BankAccountRow(
    BankAccount account, {
    double iconFontSize = 24,
    double textFontSize = 20,
    double spaceSize = 10,
  }) : super(
          children: [
            Padding(
              padding: EdgeInsets.only(right: spaceSize),
              child: FaIcon(
                getIcon(account),
                size: iconFontSize,
                color: AppColor.kTextOnLightColor,
              ),
            ),
            Text(
              account.name,
              style: TextStyle(
                color: AppColor.kTextOnLightColor,
                fontSize: textFontSize,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        );

  static IconData getIcon(BankAccount account) {
    if (account.bankAccountType == BankAccountType.CARD) return FontAwesomeIcons.creditCard;
    if (account.bankAccountType == BankAccountType.DEPOSIT) return FontAwesomeIcons.university;
    return FontAwesomeIcons.questionCircle;
  }
}

class HeaderBankAccountRow extends BankAccountRow {
  HeaderBankAccountRow(BankAccount account)
      : super(
          account,
          iconFontSize: 28,
          textFontSize: 24,
        );
}

class BlockBankAccountRow extends BankAccountRow {
  BlockBankAccountRow(BankAccount account) : super(account);
}
