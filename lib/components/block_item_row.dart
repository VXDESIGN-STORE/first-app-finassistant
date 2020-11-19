import 'package:first_app_finassistant/other/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlockItemRow extends InkWell {
  BlockItemRow({
    GestureTapCallback onTap,
    List<Widget> children,
    bool isRight = false,
  })  : assert(children != null && children.isNotEmpty),
        super(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isRight)
                FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: 24,
                  color: AppColor.kLinkColor,
                ),
              Column(
                crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: children,
              ),
              if (!isRight)
                FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: 24,
                  color: AppColor.kLinkColor,
                ),
            ],
          ),
        );
}
