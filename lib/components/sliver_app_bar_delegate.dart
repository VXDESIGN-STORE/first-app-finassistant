import 'dart:math';

import 'package:first_app_finassistant/components/header.dart';
import 'package:flutter/material.dart';

abstract class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  double _headerHeight;
  Header _header;
  Widget _pinnedTitle;

  SliverAppBarDelegate({
    double headerHeight,
    Header header,
    Widget pinnedTitle,
  })  : assert(headerHeight != null),
        assert(header != null) {
    _headerHeight = headerHeight;
    _header = header;
    _pinnedTitle = pinnedTitle;
  }

  double _scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed).clamp(0, 1).toDouble();
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = _scrollAnimationValue(shrinkOffset);
    return Container(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          HeaderBackground(
            height: _headerHeight,
          ),
          Opacity(
            opacity: animationVal,
            child: Container(
              height: _headerHeight,
              width: MediaQuery.of(context).size.width,
              transform: Matrix4.translationValues(0, 54 - shrinkOffset, 0),
              child: _header,
            ),
          ),
          Opacity(
            opacity: (1 - 2 * animationVal).isNegative ? 0.0 : (1 - 2 * animationVal),
            child: Padding(
              padding: EdgeInsets.only(top: 36, left: 12, right: 15),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    child: _header.leftButton,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 127,
                    alignment: Alignment.center,
                    child: _pinnedTitle,
                  ),
                  Container(
                    width: 50,
                    child: _header.rightButton,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _headerHeight;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
