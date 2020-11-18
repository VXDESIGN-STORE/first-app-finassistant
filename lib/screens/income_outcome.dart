import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/block.dart';
import 'package:first_app_finassistant/components/block_item_row.dart';
import 'package:first_app_finassistant/components/header.dart';
import 'package:first_app_finassistant/components/income_outcome_row.dart';
import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/storage.dart';
import 'package:first_app_finassistant/screens/edit_bank_account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeOutcomeScreen extends StatefulWidget {
  @override
  _IncomeOutcomeScreenState createState() => _IncomeOutcomeScreenState();
}

class _IncomeOutcomeScreenState extends State<IncomeOutcomeScreen> {
  static const double _headerHeight = 335;
  static const String _keyPrefix = "income_outcome";

  final StorageProvider storageProvider = StorageProvider.getInstance();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    setState(() {
      storageProvider.regenerateCurrencyTypeChangeKey();
      storageProvider.regenerateBankAccountChangeKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBackgroundMainAppColor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: _headerHeight),
                      child: Block(
                        width: MediaQuery.of(context).size.width,
                        title: AppText.kRecentChangesHeaderTitle,
                        items: [
                          if (storageProvider.orderedTransactions?.isNotEmpty == true)
                            for (var transaction in storageProvider.orderedTransactions)
                              BlockItemRow(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditBankAccount()), // TODO: Replace on real screen
                                  );
                                },
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: BankAccountRow(storageProvider.getBankAccount(transaction)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, left: 3),
                                    child: IncomeOutcomeRow(
                                      transaction.value,
                                      isIncome: transaction.isIncome,
                                      currencyTypeChangeKey: storageProvider.bankAccountsKey,
                                      activeType: transaction.value.type,
                                    ),
                                  ),
                                  buildLineSeparator(context, EdgeInsets.only(top: 12, bottom: 16)),
                                  Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 15),
                                            child: FaIcon(
                                              FontAwesomeIcons.calendarAlt,
                                              size: 20,
                                              color: AppColor.kTextOnLightColor,
                                            ),
                                          ),
                                          Text(
                                            transaction.formattedDate,
                                            style: TextStyle(
                                              color: AppColor.kTextOnLightColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ],
                                      )),
                                  if (transaction.description?.isNotEmpty == true) ...[
                                    buildLineSeparator(context, EdgeInsets.only(top: 16, bottom: transaction.description?.isNotEmpty == true ? 16 : 0)),
                                    Row(
                                      children: [
                                        Text(
                                          transaction.description,
                                          style: TextStyle(
                                            color: AppColor.kTextOnLightColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ],
                              )
                          else
                            Text(
                              AppText.kNoTransactions,
                              style: TextStyle(
                                color: AppColor.kTextOnLightColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                        ],
                        button: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            size: 18,
                            color: AppColor.kTextOnDarkColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditBankAccount()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              HeaderBackground(
                height: _headerHeight,
              ),
              Padding(
                padding: EdgeInsets.only(top: 54, left: 12),
                child: IconButton(
                  key: Key("$_keyPrefix:button"),
                  icon: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 24,
                    color: AppColor.kLinkColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 114),
                child: IncomeOutcomeHeader(
                  key: storageProvider.currencyTypeChangeKey,
                  income: storageProvider.transactions.where((transaction) => transaction.isIncome).map((transaction) => transaction.value).sum(storageProvider.summaryType),
                  outcome: storageProvider.transactions.where((transaction) => !transaction.isIncome).map((transaction) => transaction.value).sum(storageProvider.summaryType),
                  activeType: storageProvider.summaryType,
                  changeCurrencyType: (type) {
                    storageProvider.changeCurrencyType(type, setState);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildLineSeparator(BuildContext context, EdgeInsets insets) {
    return Container(
      margin: insets,
      height: 1,
      width: MediaQuery.of(context).size.width - 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.kTextOnLightColor,
            AppColor.kBackgroundSummaryElementColor,
          ],
        ),
      ),
    );
  }
}
