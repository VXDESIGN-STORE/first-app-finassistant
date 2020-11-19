import 'package:first_app_finassistant/components/marquee_text.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class BankAccountRow extends Row {
  BankAccountRow(
    double width,
    BankAccount account, {
    Key key,
    isLink = false,
    double iconFontSize = 24,
    double textFontSize = 20,
    double spaceSize = 10,
  }) : super(
          children: [
            Padding(
              padding: EdgeInsets.only(right: spaceSize),
              child: Text(
                account.currencyType.getSign(),
                style: TextStyle(
                  color: isLink ? AppColor.kLinkColor : AppColor.kTextOnLightColor,
                  fontSize: textFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: spaceSize),
              child: FaIcon(
                account.bankAccountType.getIcon(),
                size: iconFontSize,
                color: isLink ? AppColor.kLinkColor : AppColor.kTextOnLightColor,
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
                    color: isLink ? AppColor.kLinkColor : AppColor.kTextOnLightColor,
                    fontSize: textFontSize,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        );
}

class HeaderBankAccountRow extends BankAccountRow {
  HeaderBankAccountRow(
    BuildContext context,
    BankAccount account, {
    Key key,
  }) : super(
          MediaQuery.of(context).size.width - 130,
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
          MediaQuery.of(context).size.width - 230,
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
          MediaQuery.of(context).size.width - 230,
          account,
          key: key,
        );
}

class SelectionBankAccountRow extends BankAccountRow {
  SelectionBankAccountRow(
    BuildContext context,
    BankAccount account, {
    Key key,
    bool isLink = false,
  }) : super(
          MediaQuery.of(context).size.width - 250,
          account,
          key: key,
          isLink: isLink,
          iconFontSize: 28,
          textFontSize: 24,
        );
}
