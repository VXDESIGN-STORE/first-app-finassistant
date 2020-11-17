import 'package:first_app_finassistant/components/money_value_row.dart';
import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeOutcomeRow extends Row {
  IncomeOutcomeRow(
    MoneyValue value, {
    bool isIncome = true,
    Key currencyTypeChangeKey,
    CurrencyType activeType,
  }) : super(
          children: [
            BlockMoneyValueRow(
              value,
              key: currencyTypeChangeKey,
              activeType: activeType,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: FaIcon(
                isIncome ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
                size: 20,
                color: isIncome ? AppColor.kArrowIncomeColor : AppColor.kArrowOutcomeColor,
              ),
            ),
          ],
        );
}

class IncomeRow extends IncomeOutcomeRow {
  IncomeRow(
    MoneyValue income, {
    Key currencyTypeChangeKey,
    CurrencyType activeType,
  }) : super(
          income,
          currencyTypeChangeKey: currencyTypeChangeKey,
          activeType: activeType,
        );
}

class OutcomeRow extends IncomeOutcomeRow {
  OutcomeRow(
    MoneyValue outcome, {
    Key currencyTypeChangeKey,
    CurrencyType activeType,
  }) : super(
          outcome,
          isIncome: false,
          currencyTypeChangeKey: currencyTypeChangeKey,
          activeType: activeType,
        );
}
