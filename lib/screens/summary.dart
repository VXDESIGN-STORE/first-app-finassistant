import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/block.dart';
import 'package:first_app_finassistant/components/block_item_row.dart';
import 'package:first_app_finassistant/components/header.dart';
import 'package:first_app_finassistant/components/income_outcome_row.dart';
import 'package:first_app_finassistant/components/money_value_row.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/entities/money_value.dart';
import 'package:first_app_finassistant/enums/bank_account_type.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/currency_rates.dart';
import 'package:first_app_finassistant/screens/edit_bank_account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  static const double headerHeight = 215;

  MoneyValue _summaryValue = MoneyValue.zero;
  CurrencyType _summaryType = CurrencyType.RUR;
  List<MoneyValue> _incomeValues = [];
  List<MoneyValue> _outcomeValues = [];
  Key _currencyTypeChangeKey = Key("");
  Key _bankAccountsKey = Key("");
  List<BankAccount> _accounts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var prefs = await SharedPreferences.getInstance();
    await CurrencyRates.loadRates();

    setState(() {
      var value = prefs.getString(AppSharedKey.kSummaryValue);
      _summaryValue = value?.isNotEmpty == true ? MoneyValue.fromJson(value) : MoneyValue.zero;
      _summaryType = CurrencyType.values[(prefs.getInt(AppSharedKey.kActiveType) ?? 0)];
      _currencyTypeChangeKey = UniqueKey();
      _bankAccountsKey = UniqueKey();
      // _incomeValues = prefs.getStringList(AppSharedKey.kIncomeValues).map(MoneyValue.fromJson).toList();
      // _outcomeValues = prefs.getStringList(AppSharedKey.kOutcomeValues).map(MoneyValue.fromJson).toList();
      // _accounts = prefs.getStringList(AppSharedKey.kAccounts).map(BankAccount.fromJson).toList();
      _incomeValues = [
        MoneyValue(520, CurrencyType.RUR),
        MoneyValue(5, CurrencyType.EUR),
      ];
      _outcomeValues = [
        MoneyValue(225, CurrencyType.RUR),
      ];
      _accounts = [
        BankAccount(UniqueKey().toString(), "Sberbank", BankAccountType.CARD, MoneyValue(100, CurrencyType.RUR)),
        BankAccount(UniqueKey().toString(), "Tinkoff", BankAccountType.DEPOSIT, MoneyValue(244, CurrencyType.EUR)),
        BankAccount(UniqueKey().toString(), "Alfa-Bank", null, MoneyValue(500, CurrencyType.USD)),
      ];
    });
  }

  _changeCurrencyType(CurrencyType type) async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_summaryType != type) {
        _summaryType = type;
        prefs.setInt(AppSharedKey.kActiveType, _summaryType.index);
        _currencyTypeChangeKey = Key(_summaryType.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: EdgeInsets.only(top: headerHeight),
                      child: Block(
                        width: MediaQuery.of(context).size.width,
                        title: AppText.kIncomeOutcomeHeaderTitle,
                        items: [
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
                                child: IncomeRow(
                                  _incomeValues.sum(_summaryType),
                                  currencyTypeChangeKey: _currencyTypeChangeKey,
                                  activeType: _summaryType,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2.5),
                                child: OutcomeRow(
                                  _outcomeValues.sum(_summaryType),
                                  currencyTypeChangeKey: _currencyTypeChangeKey,
                                  activeType: _summaryType,
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
                          if (_accounts?.isNotEmpty == true)
                            for (var account in _accounts)
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
                                      key: _bankAccountsKey,
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
                height: headerHeight,
              ),
              Padding(
                padding: EdgeInsets.only(top: 54),
                child: SummaryHeader(
                  key: _currencyTypeChangeKey,
                  value: _summaryValue,
                  activeType: _summaryType,
                  changeCurrencyType: _changeCurrencyType,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}