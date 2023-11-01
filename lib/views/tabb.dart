import 'package:flutter/material.dart';

import '../page/findPage.dart';
import '../page/homePage.dart';
import '../page/myPage.dart';
import '../page/shopPage.dart';
import 'Tabbar.dart';


class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      label: "首页",
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.green,
      icon: Icon(Icons.message),
      label: "消息",
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.amber,
      icon: Icon(Icons.shopping_cart),
      label: "购物车",
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.red,
      icon: Icon(Icons.person),
      label: "个人中心",
    ),
  ];
  int currentIndex = 0;

  final pages = [homePage(), findPage(), shopPage(), myPage()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }
  PageTag tabBarType = PageTag.home;
  @override
  Widget build(BuildContext context) {
    //   Widget? currentPage;
    //   switch (tabBarType){
    //     case PageTag.home:
    //       break;
    //     case PageTag.find:
    //       currentPage = findPage();
    //       break;
    //     case PageTag.shop:
    //       currentPage = shopPage();
    //       break;
    //     case PageTag.my:
    //       currentPage = myPage();
    //       break;
    //   }
    //   double a = MediaQuery.of(context).size.aspectRatio;
    //   bool hasBottomPadding = a < 0.55;
    //
    //   bool hasBackground = hasBottomPadding;
    //   hasBackground = tabBarType != PageTag.home;
    //   if (hasBottomPadding) {
    //     hasBackground = true;
    //   }
    //   Widget tikTokTabBar = Tabbar(
    //     hasBackground: hasBackground,
    //     current: tabBarType,
    //     onTabSwitch: (type) async {
    //       setState(() {
    //         tabBarType = type;
    //         // if (type == PageTag.home) {
    //         //   _videoListController.currentPlayer.play();
    //         // } else {
    //         //   _videoListController.currentPlayer.pause();
    //         // }
    //       });
    //     },
    //     // onAddButton: () {
    //     //   Navigator.of(context).push(
    //     //     MaterialPageRoute(
    //     //       fullscreenDialog: true,
    //     //       builder: (context) => CameraPage(),
    //     //     ),
    //     //   );
    //     // },
    //   );
    //   return tikTokTabBar;
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text("底部导航栏"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          _changePage(index);
        },
      ),
      body: pages[currentIndex],
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}

