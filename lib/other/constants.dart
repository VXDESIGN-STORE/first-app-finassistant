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
  static const kBankAccountLabel = "Bank Account";
  static const kValueLabel = "Value";
  static const kValueHint = "Enter a value";
  static const kDateLabel = "Date";
  static const kDescriptionLabel = "Description";
  static const kDescriptionHint = "Enter a description";
  static const kDeleteTransaction = "Delete This Change?";
  static const kSelectBankAccount = "Select a bank account";
  static const kBankNameLabel = "Name";
  static const kBankNameHint = "Enter a name";
  static const kBankAccountTypeLabel = "Account Type";
  static const kCurrencyRateLabel = "Account Rate";
  static const kDeleteBankAccount = "Delete This Bank Account?";
  static const kSelectBankAccountType = "Select an account type";
  static const kSelectCurrencyRate = "Select an account rate";
  static const kEmptyField = "—";
  static const kSomeFieldsAreMissed = "Some fields are missed";
  static const kTransactionRemovalConfirmation = "Are you confirm change removal?";
  static const kBankAccountRemovalConfirmation = "Are you confirm bank account removal?";
}

// Shared Preferences Keys
class AppSharedKey {
  static const kCurrencyRatesLastDateUpdate = "currencyRatesLastDateUpdate";
  static const kActiveType = "activeType";
  static const kTransactions = "transactions";
  static const kBankAccounts = "bankAccounts";
}