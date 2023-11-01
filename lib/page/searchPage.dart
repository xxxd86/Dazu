
import 'package:dazu/views/image_swiper_widget.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'package:flutter/material.dart';

import 'package:tapped/tapped.dart';

import '../style/style.dart';

class SearchPage extends StatefulWidget {
  final Function? onPop;

  const SearchPage({
    Key? key,
    this.onPop,
  }) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List swiperDataList=["https://img.ivsky.com/img/tupian/li/201810/30/motianlun-005.jpg",
    "https://img.ivsky.com/img/tupian/li/201811/06/xiaosongshu-002.jpg",
    "https://img.ivsky.com/img/tupian/li/201811/06/ludeng-006.jpg"];
  @override
  Widget build(BuildContext context) {
    Widget head = Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Colors.red,
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.fullscreen,
              size: 24,
            ),
            Expanded(
              child: Container(
                height: 32,
                margin: EdgeInsets.only(right: 20, left: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.only(left: 12),
                child: Opacity(
                  opacity: 0.3,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 2, bottom: 2),
                        child: Text(
                          '搜索内容',
                          style: StandardTextStyle.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Tapped(
              child: Text(
                '取消',
                style: StandardTextStyle.normal.apply(color: ColorPlate.orange),
              ),
              onTap: widget.onPop,
            ),
          ],
        ),
      ),
    );
    Widget body = ListView(
      padding: EdgeInsets.zero,

      children: <Widget>[
        _SearchSelectRow(hotsearch: "'卡努'台风是否要去日本",),
        _SearchSelectRow(hotsearch: "Apritag对于场景统一的重要性",),
        _SearchSelectRow(hotsearch: "人工智能与实时渲染",),
        Opacity(
          opacity: 0.6,
          child: Container(
            height: 46,
            child: Center(child: Text('全部搜索记录')),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: AspectRatio(
            aspectRatio: 4.0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorPlate.darkGray,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: SettingsPage()
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      body: Container(
        color: Color(0x99a7c425),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            head,
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _SearchSelectRow extends StatelessWidget {
  final String hotsearch;
  const _SearchSelectRow({
    Key? key, required this.hotsearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.timelapse,
            size: 20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8, bottom: 1),
              child: Text(
                this.hotsearch,
                style: StandardTextStyle.normal,
              ),
            ),
          ),
          Icon(
            Icons.clear,
            size: 20,
          ),
        ],
      ),
    );
  }
}
