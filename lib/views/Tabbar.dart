import 'package:dazu/views/selectText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/style.dart';
enum PageTag {
  home,
  find,
  shop,
  my,
}
class Tabbar extends StatelessWidget {
  final Function(PageTag)? onTabSwitch;
  final Function()? onAddButton;

  final bool hasBackground;
  final PageTag? current;
  const Tabbar({super.key, this.onTabSwitch, this.onAddButton,  this.hasBackground = false, this.current});

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    Widget row = Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == PageTag.home,
              title: '首页',
            ),
            onTap: () => onTabSwitch?.call(PageTag.home),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == PageTag.find,
              title: '朋友',
            ),
            onTap: () => onTabSwitch?.call(PageTag.find),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: Icon(
              Icons.add_box,
              size: 32,
            ),
            onTap: () => onAddButton?.call(),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == PageTag.shop,
              title: '消息',
            ),
            onTap: () => onTabSwitch?.call(PageTag.shop),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == PageTag.my,
              title: '我',
            ),
            onTap: () => onTabSwitch?.call(PageTag.my),
          ),
        ),
      ],
    );
    return Container(
      color: hasBackground ? ColorPlate.back2 : ColorPlate.back2.withOpacity(0),
      child: Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        height: 50 + padding.bottom,
        child: row,
      ),
    );
  }
  }
