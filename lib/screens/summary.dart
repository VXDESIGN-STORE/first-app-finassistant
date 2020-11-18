import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/block.dart';
import 'package:first_app_finassistant/components/block_item_row.dart';
import 'package:first_app_finassistant/components/header.dart';
import 'package:first_app_finassistant/components/income_outcome_row.dart';
import 'package:first_app_finassistant/components/money_value_row.dart';
import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/currency_rates.dart';
import 'package:first_app_finassistant/other/storage.dart';
import 'package:first_app_finassistant/screens/edit_bank_account.dart';
import 'package:first_app_finassistant/screens/income_outcome.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  static const double _headerHeight = 215;
  static const String _keyPrefix = "summary";

  final StorageProvider storageProvider = StorageProvider.getInstance();

  Future<bool> _loadingFlag;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var preferences = await SharedPreferences.getInstance();
    await CurrencyRates.loadRates();

    _loadingFlag = Future.value(true);

    setState(() {
      storageProvider.setData(preferences);

      storageProvider.regenerateCurrencyTypeChangeKey();
      storageProvider.regenerateBankAccountChangeKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadingFlag,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        Widget screen;

        if (snapshot.connectionState == ConnectionState.done) {
          screen = Scaffold(
            key: ValueKey(0),
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
                              title: AppText.kIncomeOutcomeHeaderTitle,
                              items: [
                                BlockItemRow(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => IncomeOutcomeScreen()),
                                    ).then((value) => setState(() {}));
                                  },
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.5),
                                      child: IncomeRow(
                                        storageProvider.transactions.where((transaction) => transaction.isIncome).map((transaction) => transaction.value).sum(storageProvider.summaryType),
                                        currencyTypeChangeKey: storageProvider.currencyTypeChangeKey,
                                        activeType: storageProvider.summaryType,
                                        isRight: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.5),
                                      child: OutcomeRow(
                                        storageProvider.transactions.where((transaction) => !transaction.isIncome).map((transaction) => transaction.value).sum(storageProvider.summaryType),
                                        currencyTypeChangeKey: storageProvider.currencyTypeChangeKey,
                                        activeType: storageProvider.summaryType,
                                        isRight: true,
                                      ),
                                    ),
                                  ],
                                  isRight: true,
                                ),
                              ],
                              isRight: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Block(
                              width: MediaQuery.of(context).size.width,
                              title: AppText.kBankAccountsHeaderTitle,
                              items: [
                                if (storageProvider.accounts?.isNotEmpty == true)
                                  for (var account in storageProvider.accounts)
                                    BlockItemRow(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => EditBankAccount()), // TODO: Replace on real screen
                                        );
                                      },
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 2.5),
                                          child: BankAccountRow(account),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2.5),
                                          child: BlockMoneyValueRow(
                                            account.value,
                                            key: storageProvider.bankAccountsKey,
                                          ),
                                        ),
                                      ],
                                    )
                                else
                                  Text(
                                    AppText.kNoBankAccounts,
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
                      padding: EdgeInsets.only(top: 54),
                      child: SummaryHeader(
                        key: storageProvider.currencyTypeChangeKey,
                        value: storageProvider.accounts.map((account) => account.value).sum(storageProvider.summaryType),
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
        } else {
          screen = Scaffold(
            key: ValueKey(1),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(AppColor.kTextOnLightColor),
                  ),
                ],
              ),
            ),
          );
        }

        return AnimatedSwitcher(
          duration: Duration(seconds: 1),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          child: screen,
        );
      },
    );
  }
}
