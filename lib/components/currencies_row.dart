import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';

class CurrenciesRow extends Row {
  CurrenciesRow(
    CurrencyType activeType,
    Function(CurrencyType) changeCurrencyType,
  ) : super(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var type in CurrencyType.values)
              FlatButton(
                minWidth: 5,
                child: Text(
                  type.getSign(),
                  style: TextStyle(
                    color: _getActiveColor(activeType, type),
                    fontSize: 20,
                    fontWeight: _getActiveWeight(activeType, type),
                  ),
                ),
                onPressed: () {
                  changeCurrencyType(type);
                },
              ),
          ],
        );

  static Color _getActiveColor(CurrencyType activeType, CurrencyType rowType) {
    return activeType == rowType ? AppColor.kTextOnLightColor : AppColor.kLinkColor;
  }

  static FontWeight _getActiveWeight(CurrencyType activeType, CurrencyType rowType) {
    return activeType == rowType ? FontWeight.w700 : FontWeight.w500;
  }
}
