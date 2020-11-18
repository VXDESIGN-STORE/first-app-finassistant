import 'package:first_app_finassistant/components/marquee_text.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class BankAccountRow extends Row {
  BankAccountRow(
    double width,
    BankAccount account, {
    Key key,
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
            Container(
              width: width,
              child: MarqueeText(
                key: key,
                direction: Axis.horizontal,
                child: Text(
                  account.name,
                  key: key,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    color: AppColor.kTextOnLightColor,
                    fontSize: textFontSize,
                    fontWeight: FontWeight.w300,
                  ),
                ),
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
  HeaderBankAccountRow(
    BuildContext context,
    BankAccount account, {
    Key key,
  }) : super(
          MediaQuery.of(context).size.width - 100,
          account,
          key: key,
          iconFontSize: 28,
          textFontSize: 24,
        );
}

class TitleBankAccountRow extends BankAccountRow {
  TitleBankAccountRow(
    BuildContext context,
    BankAccount account, {
    Key key,
  }) : super(
          MediaQuery.of(context).size.width - 200,
          account,
          key: key,
          iconFontSize: 28,
          textFontSize: 24,
        );
}

class BlockBankAccountRow extends BankAccountRow {
  BlockBankAccountRow(
    BuildContext context,
    BankAccount account, {
    Key key,
  }) : super(
          MediaQuery.of(context).size.width - 200,
          account,
          key: key,
        );
}
