import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/currencies_row.dart';
import 'package:first_app_finassistant/components/money_value_row.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderBackground extends Container {
  HeaderBackground({double height})
      : assert(height > 0),
        super(
          height: height,
          decoration: BoxDecoration(
            color: AppColor.kBackgroundSummaryElementColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.kBoxShadowColor,
                offset: Offset(0.0, 3.0),
                blurRadius: 20.0,
                // spreadRadius: 10.0,
              ),
            ],
          ),
        );
}

class Header extends Column {
  Header({
    Key key,
    Widget item,
    CurrencyType activeType,
    String title,
    Widget customTitle,
    Function(CurrencyType) changeCurrencyType,
  })  : assert(item != null),
        assert(activeType != null),
        assert(title == null && customTitle != null || title != null && customTitle == null),
        assert(changeCurrencyType != null),
        super(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, bottom: 10),
              child: customTitle == null ? getTitleWidget(title) : customTitle,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
              child: item,
            ),
            CurrenciesRow(
              activeType: activeType,
              changeCurrencyType: changeCurrencyType,
            ),
          ],
        );

  static Text getTitleWidget(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColor.kTextOnLightColor,
        fontSize: 24,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class SummaryHeader extends Header {
  SummaryHeader({
    Key key,
    MoneyValue value,
    CurrencyType activeType,
    Function(CurrencyType) changeCurrencyType,
  }) : super(
          key: key,
          item: HeaderMoneyValueRow(
            value,
            key: key,
            activeType: activeType,
          ),
          activeType: activeType,
          title: AppText.kSummaryHeaderTitle,
          changeCurrencyType: changeCurrencyType,
        );
}

class IncomeOutcomeHeader extends Header {
  IncomeOutcomeHeader({
    Key key,
    MoneyValue income,
    MoneyValue outcome,
    CurrencyType activeType,
    Function(CurrencyType) changeCurrencyType,
  }) : super(
          key: key,
          item: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: FaIcon(
                        FontAwesomeIcons.arrowUp,
                        size: 20,
                        color: AppColor.kArrowIncomeColor,
                      ),
                    ),
                    HeaderMoneyValueRow(
                      income,
                      key: key,
                      activeType: activeType,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: FaIcon(
                        FontAwesomeIcons.arrowDown,
                        size: 20,
                        color: AppColor.kArrowOutcomeColor,
                      ),
                    ),
                    HeaderMoneyValueRow(
                      outcome,
                      key: key,
                      activeType: activeType,
                    ),
                  ],
                ),
              ),
            ],
          ),
          activeType: activeType,
          title: AppText.kIncomeOutcomeHeaderTitle,
          changeCurrencyType: changeCurrencyType,
        );
}

class AccountHeader extends Header {
  AccountHeader({
    Key key,
    BankAccount account,
    MoneyValue value,
    CurrencyType activeType,
    Function(CurrencyType) changeCurrencyType,
  }) : super(
          key: key,
          item: HeaderMoneyValueRow(
            value,
            key: key,
            activeType: activeType,
          ),
          activeType: activeType,
          customTitle: HeaderBankAccountRow(account),
          changeCurrencyType: changeCurrencyType,
        );
}
