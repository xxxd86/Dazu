import 'package:dazu/page/searchPage.dart';
import 'package:dazu/page/shopPage.dart';
import 'package:dazu/page/userPage.dart';
import 'package:dazu/views/dazuScaffold.dart';
import 'package:dazu/views/image_swiper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:go_router/go_router.dart';
import 'package:tapped/tapped.dart';


import '../controller/text.dart';
import '../hotel_booking/hotel_home_screen.dart';
import '../views/ColumeHome.dart';
import '../views/Tabbar.dart';
import '../views/TempBox.dart';
import '../views/bottom3/bottom_bar_3.dart';
import '../views/bottom3/tabIcon_data.dart';
import '../views/rowFuntions.dart';
import '../views/tikTokHeader.dart';
import 'findPage.dart';
import 'followPage.dart';
import 'myPage.dart';
import 'newtext.dart';
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  HotelHomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return  DetailsScreen();
          },
        ),
      ],
    ),
  ],
);
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> with WidgetsBindingObserver{
  ScaffoldController tkController = ScaffoldController();
  final List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  PageTag tabBarType = PageTag.home;
  int pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Widget? currentPage;
    switch (tabBarType){
      case PageTag.home:
        break;
      case PageTag.find:
        currentPage = FollowPage();
        break;
      case PageTag.shop:
        currentPage = shopPage();
        break;
      case PageTag.my:
        currentPage = UserPage(isSelfPage: true,);
        break;
    }
    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;

    bool hasBackground = hasBottomPadding;
    hasBackground = tabBarType != PageTag.home;
    if (hasBottomPadding) {
      hasBackground = true;
    }
    Widget tikTokTabBar = Tabbar(
      hasBackground: hasBackground,
      current: tabBarType,
      onTabSwitch: (type) async {
        setState(() {
          tabBarType = type;
          // if (type == PageTag.home) {
          //   _videoListController.currentPlayer.play();
          // } else {
          //   _videoListController.currentPlayer.pause();
          // }
        });
      },
      // onAddButton: () {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       fullscreenDialog: true,
      //       builder: (context) => CameraPage(),
      //     ),
      //   );
      // },
    );
    List<Map> imgList = [
      {"url": "https://img.ivsky.com/img/tupian/li/201810/30/motianlun-005.jpg"},
      {"url": "https://img.ivsky.com/img/tupian/li/201811/06/xiaosongshu-002.jpg"},
      {"url":  "https://img.ivsky.com/img/tupian/li/201811/06/ludeng-006.jpg"},
      // {"url": "http://img5.mtime.cn/mg/2021/08/24/110937.63038065_285X160X4.jpg"},
    ];

    var userPage = UserPage(
      isSelfPage: false,
      canPop: true,
      onPop: () {
        tkController.animateToMiddle();//右划到中间跳转到用户界面
      },
    );
    var searchPage = SearchPage(
      onPop: tkController.animateToMiddle,//左划到中间跳转到搜索界面
    );
    var MySwiperWidget = Swiper(
      autoplay: true,
      duration: 1500,
      layout: SwiperLayout.TINDER,
      itemBuilder: (BuildContext context, int index) {
        //每次循环遍历时，将i赋值给index

        return Tapped(
          child: Image.network(
            imgList[index]['url'],
            // fit: BoxFit.fill,
            width: 50,
            height: 50,
          ),
          onTap: (){
            print("takeim");//实现广告点击跳转
          },
        );
      },
      itemWidth: 300.0,
      itemHeight: 200.0,
      itemCount: imgList.length,
      //指示器
      // pagination: new SwiperPagination(),
    );



    var header = tabBarType == PageTag.home
        ? TikTokHeader(
      onSearch: () {
        tkController.animateToLeft();
      },
    )
        : Container();
    void onClickBottomBar(int index) {
      if (!mounted) return;

      setState(() => pageIndex = index);
      //改变type
    }
    Widget bottomBar() {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: BottomBar3(
          current: tabBarType,
          tabIconsList: tabIconsList,
          changeIndex: (index) =>
              {
                onClickBottomBar(index)
              }
          ,
          onTabSwitch: (type) async{
            setState(() {
              tabBarType = type;
            });
          },
          addClick: () {
            debugPrint('点击了中间的按钮');
          },
        ),
      );
    }


    return dazuScaffold(
      controller: tkController,
      hasBottomPadding: hasBackground,
      tabBar: bottomBar(),
       header: tabBarType==PageTag.home?header:Container(),
      leftPage: searchPage,
      rightPage: userPage,
      enableGesture: tabBarType == PageTag.home,
      // onPullDownRefresh: _fetchData,
      //设置
      page: Stack(
        // index: currentPage == null ? 0 : 1,
        children: <Widget>[
         tabBarType==PageTag.home?
             Container(
               color: Colors.red,
               padding: EdgeInsets.only(top: 40),
               // color: Color(0xb8dde092),
               child: HotelHomeScreen()
             )
           :
      //   MaterialApp.router(
      //   routerConfig: _router,
      // ):
         Container(
           width: 0,
           height: 0,
           color: Colors.red,
         ),
          currentPage ?? Container()
        ],
      ),
    );
  }
}