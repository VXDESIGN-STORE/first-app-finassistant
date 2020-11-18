import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/block.dart';
import 'package:first_app_finassistant/components/header.dart';
import 'package:first_app_finassistant/components/sliver_app_bar_delegate.dart';
import 'package:first_app_finassistant/components/transaction_row.dart';
import 'package:first_app_finassistant/entities/bank_account.dart';
import 'package:first_app_finassistant/entities/transaction.dart';
import 'package:first_app_finassistant/enums/currency_type.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/storage.dart';
import 'package:first_app_finassistant/screens/edit_transaction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'edit_bank_account.dart';

class AccountScreen extends StatefulWidget {
  final BankAccount account;

  const AccountScreen({
    Key key,
    @required this.account,
  }) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  static const double _headerHeight = 270;
  static const String _keyPrefix = "account";

  final StorageProvider storageProvider = StorageProvider.getInstance();

  CurrencyType _activeType = CurrencyType.RUR;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    setState(() {
      _activeType = widget.account.currencyType;

      storageProvider.regenerateCurrencyTypeChangeKey();
      storageProvider.regenerateBankAccountChangeKey();
    });
  }

  _changeCurrencyType(CurrencyType type) async {
    if (_activeType != type) {
      setState(() {
        _activeType = type;
        storageProvider.regenerateCurrencyTypeChangeKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBackgroundMainAppColor,
      // body: Column(
      //   children: [
      //     Stack(
      //       children: [
      //         Container(
      //           height: MediaQuery.of(context).size.height,
      //           child: ListView(
      //             padding: EdgeInsets.only(top: 25, bottom: 25),
      //             children: [
      //               Padding(
      //                 padding: EdgeInsets.only(top: _headerHeight),
      //                 child: Block(
      //                   width: MediaQuery.of(context).size.width,
      //                   title: AppText.kRecentChangesHeaderTitle,
      //                   items: [
      //                     if (storageProvider.orderedTransactions?.where((transaction) => transaction.bankAccountId == widget.account.id)?.isNotEmpty == true)
      //                       for (var transaction in storageProvider.orderedTransactions.where((transaction) => transaction.bankAccountId == widget.account.id))
      //                         TransactionRow(
      //                           onTap: () {
      //                             Navigator.push(
      //                               context,
      //                               MaterialPageRoute(builder: (context) => EditTransactionScreen()),
      //                             );
      //                           },
      //                           transaction: transaction,
      //                           storageProvider: storageProvider,
      //                           context: context,
      //                         )
      //                     else
      //                       Text(
      //                         AppText.kNoTransactions,
      //                         style: TextStyle(
      //                           color: AppColor.kTextOnLightColor,
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.w500,
      //                         ),
      //                       )
      //                   ],
      //                   button: IconButton(
      //                     icon: FaIcon(
      //                       FontAwesomeIcons.plus,
      //                       size: 18,
      //                       color: AppColor.kTextOnDarkColor,
      //                     ),
      //                     onPressed: () {
      //                       Navigator.push(
      //                         context,
      //                         MaterialPageRoute(builder: (context) => EditTransactionScreen()),
      //                       );
      //                     },
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         HeaderBackground(
      //           height: _headerHeight,
      //         ),
      //         Padding(
      //             padding: EdgeInsets.only(top: 54, left: 12, right: 15),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 IconButton(
      //                   key: Key("$_keyPrefix:buttonBack"),
      //                   icon: FaIcon(
      //                     FontAwesomeIcons.chevronLeft,
      //                     size: 24,
      //                     color: AppColor.kLinkColor,
      //                   ),
      //                   onPressed: () {
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //                 IconButton(
      //                   key: Key("$_keyPrefix:buttonEdit"),
      //                   icon: FaIcon(
      //                     FontAwesomeIcons.edit,
      //                     size: 24,
      //                     color: AppColor.kLinkColor,
      //                   ),
      //                   onPressed: () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(builder: (context) => EditBankAccountScreen()),
      //                     );
      //                   },
      //                 ),
      //               ],
      //             )),
      //         Padding(
      //           padding: EdgeInsets.only(top: 114),
      //           child: AccountHeader(
      //             key: storageProvider.currencyTypeChangeKey,
      //             account: widget.account,
      //             value: storageProvider.transactions.sumOfAccount(_activeType, widget.account),
      //             activeType: _activeType,
      //             changeCurrencyType: (type) => _changeCurrencyType(type),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _AccountSliverAppBarDelegate(
              context: context,
              keyPrefix: _keyPrefix,
              headerHeight: _headerHeight,
              account: widget.account,
              activeType: _activeType,
              storageProvider: storageProvider,
              changeCurrencyType: _changeCurrencyType,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 100),
                  child: Block(
                    width: MediaQuery.of(context).size.width,
                    title: AppText.kRecentChangesHeaderTitle,
                    items: [
                      if (storageProvider.orderedTransactions?.where((transaction) => transaction.bankAccountId == widget.account.id)?.isNotEmpty == true)
                        for (var transaction in storageProvider.orderedTransactions.where((transaction) => transaction.bankAccountId == widget.account.id))
                          TransactionRow(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditTransactionScreen()),
                              );
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
                        );
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

class _AccountSliverAppBarDelegate extends SliverAppBarDelegate {
  _AccountSliverAppBarDelegate({
    BuildContext context,
    String keyPrefix,
    double headerHeight,
    BankAccount account,
    CurrencyType activeType,
    StorageProvider storageProvider,
    Function(CurrencyType) changeCurrencyType,
  }) : super(
          headerHeight: headerHeight,
          header: AccountHeader(
            context: context,
            currencyTypeChangeKey: storageProvider.currencyTypeChangeKey,
            bankAccountsKey: storageProvider.bankAccountsKey,
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
            rightButton: IconButton(
              key: Key("$keyPrefix:buttonEdit"),
              icon: FaIcon(
                FontAwesomeIcons.edit,
                size: 24,
                color: AppColor.kLinkColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditBankAccountScreen()),
                );
              },
            ),
            account: account,
            value: storageProvider.transactions.sumOfAccount(activeType, account),
            activeType: activeType,
            changeCurrencyType: changeCurrencyType,
          ),
          pinnedTitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleBankAccountRow(
                context,
                account,
                key: storageProvider.bankAccountsKey,
              ),
            ],
          ),
        );
}
