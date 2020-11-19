import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

class MoneyValueRow extends Row {
  MoneyValueRow(
    MoneyValue value, {
    Key key,
    CurrencyType activeType,
    double valueFontSize = 40,
    double signFontSize = 32,
    double spaceSize = 10,
  }) : super(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Container(
              margin: EdgeInsets.only(right: spaceSize),
              child: key != null
                  ? ShowUpAnimation(
                      key: key,
                      delayStart: Duration(milliseconds: 50),
                      animationDuration: Duration(milliseconds: 300),
                      child: getValueText(value, activeType, valueFontSize),
                    )
                  : getValueText(value, activeType, valueFontSize),
            ),
            key != null
                ? ShowUpAnimation(
                    key: key,
                    delayStart: Duration(milliseconds: 100),
                    animationDuration: Duration(milliseconds: 300),
                    child: getSignText(value, activeType, signFontSize),
                  )
                : getSignText(value, activeType, signFontSize),
          ],
        );

  static getValueText(MoneyValue value, CurrencyType activeType, double valueFontSize) {
    return Text(
      value.getFormattedValue(activeType ?? value.type),
      style: TextStyle(
        color: AppColor.kTextOnLightColor,
        fontSize: valueFontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static getSignText(MoneyValue value, CurrencyType activeType, double signFontSize) {
    return Text(
      (activeType ?? value.type).getSign(),
      style: TextStyle(
        color: AppColor.kTextOnLightColor,
        fontSize: signFontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class HeaderMoneyValueRow extends MoneyValueRow {
  HeaderMoneyValueRow(
    MoneyValue value, {
    Key key,
    CurrencyType activeType,
  }) : super(
          value,
          key: key,
          activeType: activeType,
        );
}

class BlockMoneyValueRow extends MoneyValueRow {
  BlockMoneyValueRow(
    MoneyValue value, {
    Key key,
    CurrencyType activeType,
  }) : super(
          value,
          key: key,
          activeType: activeType,
          valueFontSize: 28,
          signFontSize: 22,
          spaceSize: 6,
        );
}

class SmallBlockMoneyValueRow extends MoneyValueRow {
  SmallBlockMoneyValueRow(
    MoneyValue value, {
    Key key,
    CurrencyType activeType,
  }) : super(
          value,
          key: key,
          activeType: activeType,
          valueFontSize: 24,
          signFontSize: 18,
          spaceSize: 5,
        );
}
