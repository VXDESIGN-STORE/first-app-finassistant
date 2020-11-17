import 'package:first_app_finassistant/other/constants.dart';
import 'package:first_app_finassistant/other/money_value_number_style.dart';
import 'package:first_app_finassistant/screens/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';

void main() {
  MoneyValueNumberStyle.loadSpecificNumberStyle();
  // debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppText.kApplicationTitle,
      theme: ThemeData(scaffoldBackgroundColor: AppColor.kBackgroundMainAppColor),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SummaryScreen(),
      ),
    );
  }
}
