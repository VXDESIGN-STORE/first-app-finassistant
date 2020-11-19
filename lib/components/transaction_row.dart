import 'package:first_app_finassistant/components/bank_account_row.dart';
import 'package:first_app_finassistant/components/block_item_row.dart';
import 'package:first_app_finassistant/components/income_outcome_row.dart';
import 'package:first_app_finassistant/entities/transaction.dart';
import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionRow extends BlockItemRow {
  TransactionRow({
    GestureTapCallback onTap,
    Transaction transaction,
    StorageProvider storageProvider,
    BuildContext context,
  }) : super(
          onTap: onTap,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: BlockBankAccountRow(
                context,
                storageProvider.getBankAccount(transaction),
                key: storageProvider.bankAccountsKey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 3),
              child: IncomeOutcomeRow(
                transaction.value,
                isIncome: transaction.isIncome,
                currencyTypeChangeKey: storageProvider.bankAccountsKey,
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
        );

  static Container buildLineSeparator(BuildContext context, EdgeInsets insets) {
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
