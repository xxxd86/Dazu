
import 'package:flutter/material.dart';
import 'package:safemap/safemap.dart';
import 'package:tapped/tapped.dart';

/// 单独修改了bottomSheet组件的高度
import 'package:dazu/other/bottomSheet.dart' as CustomBottomSheet;

import '../controller/tikTokVideoListController.dart';
import '../style/style.dart';
import '../views/tikTokCommentBottomSheet.dart';
import '../views/tikTokVideo.dart';
import '../views/tilTokAppBar.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  TikTokVideoListController _videoListController = TikTokVideoListController();
  PageController _pageController = PageController();
  // _videoListController.init(pageController = pageController, initialList: initialList, videoProvider: videoProvider);
  // var player = _videoListController.playerOfIndex(1)!;
  Map<int, bool> fMap = {};
  int select = 0;
  @override
  Widget build(BuildContext context) {
    Widget head = TikTokSwitchAppbar(
      index: select,
      list: ['推荐', '关注'],
      onSwitch: (i) => setState(() => select = i),
    );
    Widget body = ListView.builder(
      padding: EdgeInsets.only(
        bottom: 80 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: 10,
      itemBuilder: (ctx, i) {
        bool isF = SafeMap(fMap)[i].boolean;
        return FollowRow(
          isFavorite: isF,
          onFavorite: () {
            setState(() {
              fMap[i] = !isF;
            });
          },
          onAddFavorite: () {
            setState(() {
              fMap[i] = true;
            });
          },
          onComment: () {
            CustomBottomSheet.showModalBottomSheet(
              backgroundColor: Colors.white.withOpacity(0),
              context: context,
              builder: (BuildContext context) => TikTokCommentBottomSheet(),
            );
          },
          //分享
          onShare: () {},
        );
      },
    );
    return Container(
      color: ColorPlate.back1,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          head,
          Expanded(child: body),
        ],
      ),
    );
  }
}

class FollowRow extends StatelessWidget {
  final bool? isFavorite;
  final Function? onFavorite;
  final Function? onComment;
  final Function? onShare;
  final Function? onAddFavorite;

  const FollowRow({
    Key? key,
    this.isFavorite,
    this.onFavorite,
    this.onComment,
    this.onShare,
    this.onAddFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget video = TikTokVideoPage(
      // rightButtonColumn: true,
      aspectRatio: 6.0 / 9,
      onAddFavorite: onAddFavorite,
      userInfoWidget: Container()
    );
    video = Container(
      alignment: Alignment.topLeft,
      height: 400,
      child: AspectRatio(
        aspectRatio: 6.0 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: video,
        ),
      ),
    );
    Widget userInfo = Row(
      children: <Widget>[
        Container(
          height: 32,
          width: 32,
          child: ClipOval(
            child: Image.network(
              "https://ts1.cn.mm.bing.net/th/id/R-C.1c4c6bee39fc57b121d7d7d820ea66d6?rik=tsVnLybnav9a5g&riu=http%3a%2f%2fimg.zcool.cn%2fcommunity%2f0128005836a935a8012060c8e7e933.gif&ehk=Ms%2bcq9KNjYftse6ceKf4wRJ7h03jf%2f3%2f6s8fDaPXXrs%3d&risl=&pid=ImgRaw&r=0",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            '潇潇说',
            style: StandardTextStyle.normalW,
          ),
        )
      ],
    );
    Widget content = Padding(
      padding: const EdgeInsets.fromLTRB(2, 6, 50, 8),
      child: Text(
        '这个环境不错',
        style: StandardTextStyle.normal,
      ),
    );
    var buttonRow = Row(
      children: <Widget>[
        Text(
          '10-9',
          style: StandardTextStyle.smallWithOpacity,
        ),
        Expanded(child: Container()),
        _RowButton(
          iconData: Icons.share,
          title: '分享',
        ),
        _RowButton(
          iconData: Icons.mode_comment,
          size: SysSize.iconNormal - 2,
          title: '评论',
          onTap: onComment,
        ),
        _RowButton(
          color: isFavorite! ? ColorPlate.red : null,
          iconData: Icons.favorite,
          title: '赞',
          onTap: onFavorite,
        ),
      ],
    );
    return Container(
       // color: Colors.red,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.redAccent,
          ),
        ),
      ),
      // padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Container(
        color: Color(0xB8EFEFE1),
        child:
        Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userInfo,
            Image.asset("assets/static/home/p1png.png",width: 100,),
            content,
            // video,
            Opacity(
              opacity: 0.8,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 12, 8),
                child: buttonRow,
              ),
            )
          ],
        ),
      )
    );
  }
}

class _RowButton extends StatelessWidget {
  final IconData? iconData;
  final Color? color;
  final double? size;
  final String? title;
  final Function? onTap;

  const _RowButton({
    Key? key,
    this.iconData,
    this.size,
    this.title,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tapped(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            Icon(
              iconData ?? Icons.favorite,
              size: size ?? SysSize.iconNormal,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                title ?? '??',
                style: StandardTextStyle.small,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
