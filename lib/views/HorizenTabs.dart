import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizenTabs extends StatefulWidget {
  final String imgUrl;
  final String imgName;
  const HorizenTabs({super.key, required this.imgUrl, required this.imgName});

  @override
  State<HorizenTabs> createState() => _HorizenTabsState();
}

class _HorizenTabsState extends State<HorizenTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: Column(
        children: [
          FloatingActionButton(onPressed: (){},child: Image.asset("assets/img/temp.png"),),
          Text(widget.imgName)
        ],
      ),
    );

  }
}