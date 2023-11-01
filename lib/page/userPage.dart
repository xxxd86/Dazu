

// import 'package:dyle/pages/loginPage.dart';
// import 'package:dyle/pages/todoPage.dart';
//
// import 'package:dyle/pages/userDetailPage.dart';
// import 'package:dyle/style/style.dart';
// import 'package:dyle/views/topToolRow.dart';
import 'package:dazu/page/todoPage.dart';
import 'package:dazu/page/userDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tapped/tapped.dart';
// import 'package:leancloud_storage/leancloud.dart';

import '../main.dart';
import '../style/style.dart';
import '../views/topToolRow.dart';
import 'loginPage.dart';
import 'dart:io';
// Future initLeanCloud() async {
//   LeanCloud.initialize(
//       'egMQ9Slas39wLicwoDsKyefZ-gzGzoHsz', 'Ct7JRP1bWhatDtXnEuqM5j4o',
//       server: 'https://please-replace-with-your-customized.domain.com',
//       queryCache: LCQueryCache());
//   print("hasrun client");
// }

int choice = 1;
Future<void> _showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, '江南第一神情', '在吗', platformChannelSpecifics,payload: 'item x');
}
class UserPage extends StatefulWidget {
  final bool canPop;
  final bool isSelfPage;
  final Function? onPop;
  final Function? onSwitch;

  const UserPage({
    Key? key,
    this.canPop = false,
    this.onPop,
    required this.isSelfPage,
    this.onSwitch,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}
// Future<void>  addelement() async {
//   // 构建对象
//   LCObject todo = LCObject("Todo");
// // 为属性赋值
//   todo['title'] = '马拉松报名';
//   todo['priority'] = 2;
// // 将对象保存到云端
//    await todo.save();
// }

class _UserPageState extends State<UserPage> {
  bool _notificationsEnabled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var android =  AndroidInitializationSettings('@mipmap/ic_launcher');
    //初始化通知栏
    final InitializationSettings initializationSettings = InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {

      switch (notificationResponse.notificationResponseType) {

        case NotificationResponseType.selectedNotification:
          Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => TodoPage(),
              ));
          print("sssoso");
          break;
        case NotificationResponseType.selectedNotificationAction:
          break;
      }
    });
    _isAndroidPermissionGranted();
    _requestPermissions();
    requestNotificationPermissions();
  }
  Future<void> requestNotificationPermissions() async {
    // 请求通知权限
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission(
    );
  }
  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
        print(_notificationsEnabled);
      });
      print(_notificationsEnabled);
    }
  }
  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget likeButton = Container(
      color: ColorPlate.back1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Tapped(
            child: _UserRightButton(
              title: widget.isSelfPage ? '钱包' : '关注',

            ),
            onTap: () async {
               await _showNotification();
            },
          ),
          FloatingActionButton(onPressed: (){

          })
        ],
      ),
    );
    Widget avatar = Container(
      height: 120 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(left: 18),
      alignment: Alignment.bottomLeft,
      child: OverflowBox(
        alignment: Alignment.bottomLeft,
        minHeight: 20,
        maxHeight: 300,
        child: Container(
          height: 74,
          width: 74,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            color: Colors.orange,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          // child: ClipOval(
          //   child: Image.network(
          //     "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
          //     fit: BoxFit.cover,
          //
          //   ),
          // ),
          child:FloatingActionButton(onPressed: () {
            print("login");
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => LoginPage(),
              ),
            );
          },
            child: ClipOval(
              child: Image.network(
                "https://ts1.cn.mm.bing.net/th/id/R-C.1c4c6bee39fc57b121d7d7d820ea66d6?rik=tsVnLybnav9a5g&riu=http%3a%2f%2fimg.zcool.cn%2fcommunity%2f0128005836a935a8012060c8e7e933.gif&ehk=Ms%2bcq9KNjYftse6ceKf4wRJ7h03jf%2f3%2f6s8fDaPXXrs%3d&risl=&pid=ImgRaw&r=0",
                fit: BoxFit.cover,
              ),
            ),
          )
        ),
      ),
    );
    Widget body = ListView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      children: <Widget>[
        Container(height: 20),
        // 头像与关注
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[likeButton, avatar],
        ),
        Container(
          color: ColorPlate.back1,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 18),
                color: ColorPlate.back1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '潇潇说',
                      style: StandardTextStyle.big,
                    ),
                    Container(height: 8),
                    Text(
                      '朴实无华，且枯燥',
                      style: StandardTextStyle.smallWithOpacity.apply(
                        color: Colors.white,
                      ),
                    ),
                    Container(height: 10),
                    Row(
                      children: <Widget>[
                        _UserTag(tag: '幽默'),
                        _UserTag(tag: '机智'),
                        _UserTag(tag: '枯燥'),
                        _UserTag(tag: '双子座'),
                      ],
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                color: ColorPlate.back1,
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextGroup('356', '关注'),
                    TextGroup('145万', '粉丝'),
                    TextGroup('1423万', '获赞'),
                  ],
                ),
              ),
              Container(
                height: 10,
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
                 Column(
                 children: <Widget>[
                 Container(
                 color: ColorPlate.back1,
                 padding: EdgeInsets.symmetric(
                 vertical: 12,
                 ),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 //需要实现跳转内部数据变化
                 children: <Widget>[
                 _PointSelectTextButton(choice==1?true:false, '作品',onTap:()  {
                 choice = 1;
                 setState(() {});
                 // initLeanCloud();
                 }),
                 _PointSelectTextButton(choice == 2?true:false, '关注',onTap:(){
                 print("这是关注作s品");
                 setState(() {});
                 choice = 2;
                 setState(() {});
                 // addelement();
                 }),
                 _PointSelectTextButton(choice ==3?true:false, '喜欢',onTap:(){
                 print("这是喜欢作品");
                 choice =3;
                 setState(() {});
                 }),
                 ],
                 ),
    ),
    //缩略图vedio
    Container(
    child: Row(
    children: <Widget>[
    _SmallVideo(),
    _SmallVideo(),
    _SmallVideo(),
    ],
    ),
    ),

    ],
    )
            ],
          ),
        ),
      ],
    );
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.orange,
            Colors.red,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 400),
            height: double.infinity,
            width: double.infinity,
            color: ColorPlate.back1,
          ),
          body,
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 62,
            child: TopToolRow(
              canPop: widget.canPop,
              onPop: widget.onPop,
              right: Tapped(
                child: Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.36),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.more_horiz,
                    size: 24,
                  ),
                ),
                onTap: () {

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => UserDetailPage(),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserRightButton extends StatelessWidget {
  const _UserRightButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 20,
      ),
      margin: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: ColorPlate.orange),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPlate.orange),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _UserTag extends StatelessWidget {
  final String? tag;
  const _UserTag({
    Key? key,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric (horizontal: 4),
      padding: EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag ?? '标签',
        style: StandardTextStyle.smallWithOpacity,
      ),
    );
  }
}

class _UserVideoTable extends StatelessWidget {
  const _UserVideoTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: ColorPlate.back1,
          padding: EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            //需要实现跳转内部数据变化
            children: <Widget>[
              _PointSelectTextButton(choice==1?true:false, '作品',onTap:()  {
                choice = 1;
                // initLeanCloud();
              }),
              _PointSelectTextButton(choice == 2?true:false, '关注',onTap:(){
                print("这是关注作s品");
                // setState(() {});
                choice = 2;
                // addelement();
              }),
              _PointSelectTextButton(choice ==3?true:false, '喜欢',onTap:(){
                print("这是喜欢作品");
                choice =3;
              }),
            ],
          ),
        ),
        //缩略图vedio
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),

      ],
    );
  }
}

class _SmallVideo extends StatelessWidget {
  const _SmallVideo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 3 / 4.0,
        child: Container(
          decoration: BoxDecoration(
            // color: ColorPlate.darkGray,
         
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: 
              Container(
                
                // child: Text(
                //   '作品',
                //   style: TextStyle(
                //     color: Colors.white.withOpacity(0.1),
                //     fontSize: 18,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                child: Image(image: NetworkImage("https://ts1.cn.mm.bing.net/th/id/R-C.4c9f798ce0a39abcab5143c1dae48dc7?rik=kLZn%2fT6va5btVg&riu=http%3a%2f%2fg.073img.com%2fuploads%2f20161112%2f00yldafwse4.jpg&ehk=2MXWUQJ8HnEh03I4Bie1McsjosnVaFFV18xLuZn0ObU%3d&risl=&pid=ImgRaw&r=0"),
                  
                ),
              )
       
        ),
      ),
    );
  }
}

// class _PointSelectTextButton extends StatelessWidget {
//   final bool isSelect;
//   final String title;
//   final Function? onTap;
//   const _PointSelectTextButton(
//     this.isSelect,
//     this.title, {
//     Key? key,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // return Expanded(
//     //   child: Row(
//     //     mainAxisAlignment: MainAxisAlignment.center,
//     //     children: <Widget>[
//     //       isSelect
//     //           ? Container(
//     //               width: 6,
//     //               height: 6,
//     //               decoration: BoxDecoration(
//     //                 color: ColorPlate.orange,
//     //                 borderRadius: BorderRadius.circular(3),
//     //               ),
//     //             )
//     //           : Container(),
//     //       Container(
//     //         padding: EdgeInsets.only(left: 2),
//     //         child: Text(
//     //           title,
//     //           style: isSelect
//     //               ? StandardTextStyle.small
//     //               : StandardTextStyle.smallWithOpacity,
//     //         ),
//     //       ),
//     //
//     //     ],
//     //
//     //   ),
//     // );
//     return Expanded(child: Tapped(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               isSelect
//                   ? Container(
//                       width: 6,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: ColorPlate.orange,
//                         borderRadius: BorderRadius.circular(3),
//                       ),
//                     )
//                   : Container(),
//               Container(
//                 padding: EdgeInsets.only(left: 2),
//                 child: Text(
//                   title,
//                   style: isSelect
//                       ? StandardTextStyle.small
//                       : StandardTextStyle.smallWithOpacity,
//                 ),
//               ),
//
//             ],
//
//           ),
//         onTap: this.onTap,
//     ));
//     // return Tapped(
//     //     child: Row(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: <Widget>[
//     //         isSelect
//     //             ? Container(
//     //                 width: 6,
//     //                 height: 6,
//     //                 decoration: BoxDecoration(
//     //                   color: ColorPlate.orange,
//     //                   borderRadius: BorderRadius.circular(3),
//     //                 ),
//     //               )
//     //             : Container(),
//     //         Container(
//     //           padding: EdgeInsets.only(left: 2),
//     //           child: Text(
//     //             title,
//     //             style: isSelect
//     //                 ? StandardTextStyle.small
//     //                 : StandardTextStyle.smallWithOpacity,
//     //           ),
//     //         ),
//     //
//     //       ],
//     //
//     //     ),
//     //   onTap: this.onTap,
//     // );
//
//   }
// }

// class _IconTextButton extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Function onTap;
//   const _IconTextButton(
//     this.icon,
//     this.title, {
//     Key key,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(icon, color: ColorPlate.yellow),
//           Container(
//             padding: EdgeInsets.only(left: 2),
//             child: Text(
//               title,
//               style: TextStyle(color: ColorPlate.yellow),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class TextGroup extends StatelessWidget {
  final String title, tag;
  final Color? color;

  const TextGroup(
    this.title,
    this.tag, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: StandardTextStyle.big.apply(color: color),
          ),
          Container(width: 4),
          Text(
            tag,
            style: StandardTextStyle.smallWithOpacity.apply(
              color: color?.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
class _PointSelectTextButton extends StatelessWidget {
  final bool isSelect;
  final String title;
  final Function? onTap;
  const _PointSelectTextButton(
      this.isSelect,
      this.title, {
        Key? key,
        this.onTap,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       isSelect
    //           ? Container(
    //               width: 6,
    //               height: 6,
    //               decoration: BoxDecoration(
    //                 color: ColorPlate.orange,
    //                 borderRadius: BorderRadius.circular(3),
    //               ),
    //             )
    //           : Container(),
    //       Container(
    //         padding: EdgeInsets.only(left: 2),
    //         child: Text(
    //           title,
    //           style: isSelect
    //               ? StandardTextStyle.small
    //               : StandardTextStyle.smallWithOpacity,
    //         ),
    //       ),
    //
    //     ],
    //
    //   ),
    // );
    return Expanded(child: Tapped(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isSelect
              ? Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: ColorPlate.orange,
              borderRadius: BorderRadius.circular(3),
            ),
          )
              : Container(),
          Container(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              title,
              style: isSelect
                  ? StandardTextStyle.small
                  : StandardTextStyle.smallWithOpacity,
            ),
          ),

        ],

      ),
      onTap: this.onTap,
    ));
    // return Tapped(
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         isSelect
    //             ? Container(
    //                 width: 6,
    //                 height: 6,
    //                 decoration: BoxDecoration(
    //                   color: ColorPlate.orange,
    //                   borderRadius: BorderRadius.circular(3),
    //                 ),
    //               )
    //             : Container(),
    //         Container(
    //           padding: EdgeInsets.only(left: 2),
    //           child: Text(
    //             title,
    //             style: isSelect
    //                 ? StandardTextStyle.small
    //                 : StandardTextStyle.smallWithOpacity,
    //           ),
    //         ),
    //
    //       ],
    //
    //     ),
    //   onTap: this.onTap,
    // );

  }
}