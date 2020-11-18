import 'package:flutter/material.dart';

// Colors
class AppColor {
  static const kBackgroundMainAppColor = Color(0xFFF4FAFF);
  static const kBackgroundSummaryElementColor = Color(0xFFFFFFFF);
  static const kLinkColor = Color(0xFF568EA3);
  static const kBackgroundActiveElementColor = Color(0xFF23395B);
  static const kTextOnLightColor = Color(0xFF19323C);
  static const kTextOnDarkColor = kBackgroundMainAppColor;
  static const kBoxShadowColor = Colors.black26;
  static const kArrowIncomeColor = Color(0xFF216000);
  static const kArrowOutcomeColor = Color(0xFFAF0000);
}

// Texts
class AppText {
  static const kApplicationTitle = "Financial Assistant";
  static const kSummaryHeaderTitle = "Summary";
  static const kIncomeOutcomeHeaderTitle = "Income / Outcome";
  static const kBankAccountsHeaderTitle = "Bank Accounts";
  static const kRecentChangesHeaderTitle = "Recent Changes";
  static const kNoBankAccounts = "You have no registered bank account";
  static const kNoTransactions = "You have no registered transaction";
}

// Shared Preferences Keys
class AppSharedKey {
  static const kCurrencyRatesLastDateUpdate = "currencyRatesLastDateUpdate";
  static const kActiveType = "activeType";
  static const kTransactions = "Transactions";
  static const kAccounts = "accounts";
}