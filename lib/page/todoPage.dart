
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';

import '../style/style.dart';

class TodoPage extends StatelessWidget {
  final String? title;
  final String? detail;

  const TodoPage({
    Key? key,
    this.title,
    this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canpop = Navigator.of(context).canPop();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Image.network("https://gss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/9825bc315c6034a8c95b75f6c613495409237608.jpg",width: 100,height: 100,)
                ),
                Text(
                  title ?? '江南吴彦祖',
                  style: StandardTextStyle.big,
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text(
                    detail ?? '正在通话中',
                    style: StandardTextStyle.smallWithOpacity,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: canpop
                  ? Tapped(
                      child: Icon(
                        Icons.phone,
                        size: 30,
                        color: Colors.red,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : Container(),
            ),
          ),
          Expanded(
            child: Center(),
          ),
        ],
      ),
    );
  }
}
