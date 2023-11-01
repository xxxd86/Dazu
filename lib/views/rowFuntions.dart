import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HorizenTabs.dart';

class rowFuntions extends StatefulWidget {
  //横向列表
  const rowFuntions({super.key});
  @override
  State<rowFuntions> createState() => _rowFuntionsState();
}

class _rowFuntionsState extends State<rowFuntions> {
  final List<Map<String,dynamic>> _menuData = [
    {"name":"活动","img":"assets/img/close.png"},
    {"name":"活动","img":"assets/img/close.png"},
    {"name":"活动","img":"assets/img/close.png"},
    {"name":"活动","img":"assets/img/close.png"},
  ];
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
      return Container(
        height: 100,
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(5),

        ),
        child: Row(
          children: [//设置横向
            HorizenTabs(imgUrl: '', imgName: '匠心独创',),
            HorizenTabs(imgUrl: '', imgName: '私人定制',),
            HorizenTabs(imgUrl: '', imgName: '精彩活动',),
            HorizenTabs(imgUrl: '', imgName: '自由行业',),
          ],
        )
      );


  }

}



