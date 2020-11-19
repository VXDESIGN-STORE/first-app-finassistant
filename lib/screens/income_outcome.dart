import 'package:first_app_finassistant/components/block.dart';
import 'package:first_app_finassistant/components/header.dart';
import 'package:first_app_finassistant/components/sliver_app_bar_delegate.dart';
import 'package:first_app_finassistant/components/transaction_row.dart';
import 'package:first_app_finassistant/entities/transaction.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/storage.dart';
import 'package:first_app_finassistant/screens/edit_transaction.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _IncomeOutcomeSliverAppBarDelegate(
              context: context,
              keyPrefix: _keyPrefix,
              headerHeight: _headerHeight,
              storageProvider: storageProvider,
              setState: setState,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 150),
                  child: Block(
                    width: MediaQuery.of(context).size.width,
                    title: AppText.kRecentChangesHeaderTitle,
                    items: [
                      if (storageProvider.orderedTransactions?.isNotEmpty == true)
                        for (var transaction in storageProvider.orderedTransactions)
                          TransactionRow(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditTransactionScreen(transaction: transaction)),
                              ).then((value) => setState(() {}));
                            },
                            transaction: transaction,
                            storageProvider: storageProvider,
                            context: context,
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
                          MaterialPageRoute(builder: (context) => EditTransactionScreen()),
                        ).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IncomeOutcomeSliverAppBarDelegate extends SliverAppBarDelegate {
  _IncomeOutcomeSliverAppBarDelegate({
    BuildContext context,
    String keyPrefix,
    double headerHeight,
    StorageProvider storageProvider,
    Function(VoidCallback) setState,
  }) : super(
          headerHeight: headerHeight,
          header: IncomeOutcomeHeader(
            key: storageProvider.currencyTypeChangeKey,
            leftButton: IconButton(
              key: Key("$keyPrefix:buttonBack"),
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 24,
                color: AppColor.kLinkColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            income: storageProvider.transactions.sumOfIncome(storageProvider.summaryType),
            outcome: storageProvider.transactions.sumOfOutcome(storageProvider.summaryType),
            activeType: storageProvider.summaryType,
            changeCurrencyType: (type) => storageProvider.changeCurrencyType(type, setState),
          ),
          pinnedTitle: Header.getTitleWidget(AppText.kIncomeOutcomeHeaderTitle),
        );
}
