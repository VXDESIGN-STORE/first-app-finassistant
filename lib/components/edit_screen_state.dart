import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/storage.dart';
import 'package:first_app_finassistant/screens/account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class EditScreenState<T extends StatefulWidget> extends State<T> {
  final StorageProvider storageProvider = StorageProvider.getInstance();

  String get keyPrefix;

  List<Widget> getWidgets(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBackgroundSummaryElementColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 54, left: 12, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
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
                  IconButton(
                    key: Key("$keyPrefix:buttonCheck"),
                    icon: FaIcon(
                      FontAwesomeIcons.check,
                      size: 24,
                      color: AppColor.kLinkColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(AccountScreen.routeName, arguments: storageProvider.accounts[1]);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 34, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getWidgets(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @protected
  TextStyle buildTextStyleForInput() {
    return TextStyle(
      color: AppColor.kTextOnLightColor,
      fontSize: 24,
      fontWeight: FontWeight.w300,
    );
  }

  @protected
  TextStyle buildTextStyleForLabel() {
    return TextStyle(
      color: AppColor.kTextOnLightColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
  }
}
