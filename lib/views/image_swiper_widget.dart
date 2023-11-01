import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class SettingsPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<SettingsPage> {
  // late List listData;
  List swiperDataList=["https://img.ivsky.com/img/tupian/li/201810/30/motianlun-005.jpg",
    "https://img.ivsky.com/img/tupian/li/201811/06/xiaosongshu-002.jpg",
    "https://img.ivsky.com/img/tupian/li/201811/06/ludeng-006.jpg"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(

              child: Swiper(

                outer: false,
                autoplay:true,
                autoplayDelay:3000,
                //duration:5000,
                itemBuilder: (c, i) {
                  return CachedNetworkImage(
                    imageUrl:"https://ts1.cn.mm.bing.net/th/id/R-C.4c9f798ce0a39abcab5143c1dae48dc7?rik=kLZn%2fT6va5btVg&riu=http%3a%2f%2fg.073img.com%2fuploads%2f20161112%2f00yldafwse4.jpg&ehk=2MXWUQJ8HnEh03I4Bie1McsjosnVaFFV18xLuZn0ObU%3d&risl=&pid=ImgRaw&r=0",
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    fit: BoxFit.cover,
                  );

                },
                pagination:
                new SwiperPagination(
                  margin: new EdgeInsets.all(5.0),
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.black26,
                  ),

                ),
                itemCount: swiperDataList == null ? 0 : swiperDataList.length,
              ),
              constraints:
              BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 200.0))),

        ],
      ),
    );
  }
}