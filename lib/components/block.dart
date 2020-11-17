import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';

class Block extends Row {
  Block({
    double width,
    String title,
    List<Widget> items,
    Widget button,
    bool isRight = false,
  })  : assert(items != null && items.isNotEmpty),
        super(
          mainAxisAlignment: isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: width - 50,
              decoration: BoxDecoration(
                color: AppColor.kBackgroundActiveElementColor,
                borderRadius: BorderRadius.only(
                  topLeft: isRight ? Radius.circular(20) : Radius.zero,
                  bottomLeft: isRight ? Radius.circular(20) : Radius.zero,
                  topRight: !isRight ? Radius.circular(20) : Radius.zero,
                  bottomRight: !isRight ? Radius.circular(20) : Radius.zero,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.kBoxShadowColor,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30, left: 30, bottom: 15),
                      child: Row(
                        mainAxisAlignment: isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          if (button != null && isRight) ...[
                            Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(color: AppColor.kLinkColor, shape: BoxShape.circle),
                                child: button
                            ),
                            Spacer(),
                          ],
                          Text(
                            title,
                            style: TextStyle(
                              color: AppColor.kTextOnDarkColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (button != null && !isRight) ...[
                            Spacer(),
                            Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(color: AppColor.kLinkColor, shape: BoxShape.circle),
                                child: button
                            ),
                          ],
                        ],
                      ),
                    ),
                    for (var i = 0; i < items.length; i++)
                      Container(
                        alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 15, bottom: 15, right: 30, left: 30),
                        margin: getMargin(i, items.length),
                        // height: 100,
                        width: width - 65,
                        decoration: BoxDecoration(
                          color: AppColor.kBackgroundSummaryElementColor,
                          borderRadius: BorderRadius.only(
                            topLeft: isRight ? Radius.circular(15) : Radius.zero,
                            bottomLeft: isRight ? Radius.circular(15) : Radius.zero,
                            topRight: !isRight ? Radius.circular(15) : Radius.zero,
                            bottomRight: !isRight ? Radius.circular(15) : Radius.zero,
                          ),
                        ),
                        child: items[i],
                      ),
                  ],
                ),
              ),
            ),
          ],
        );

  static EdgeInsets getMargin(int index, int length) {
    if (length > 2) {
      return index != 0 && index != length - 1 ? EdgeInsets.only(top: 15, bottom: 15) : EdgeInsets.zero;
    } else if (length == 2) {
      return index == 0 ? EdgeInsets.only(bottom: 7.5) : EdgeInsets.only(top: 7.5);
    }

    return EdgeInsets.zero;
  }
}
