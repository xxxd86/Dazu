import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
 main() async {
  runApp(
    MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),

    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('保存图片到本地'),
      ),
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('保存APP里的图片'),
            ),
          ),
          RepaintBoundary(
            key: _globalKey,
            child: InkWell(
                onTap: () {
                  checkPermission(saveAssetsImg());
                },
                child: Image.asset(
                  'assets/images/avatar.png',
                  height: 200,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('保存网络图片'),
            ),
          ),
          SizedBox(
            width: 200,
            height: 100,
            child: InkWell(
                onTap: () {
                  checkPermission(saveNetworkImg(
                      "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg"));
                },
                child: Image.network(
                  "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('保存gif动画'),
            ),
          ),
          SizedBox(
            width: 200,
            height: 100,
            child: InkWell(
                onTap: () {
                  checkPermission(savegif(
                      "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif"));
                },
                child: Image.network(
                  "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif",
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                checkPermission(saveVideo());
              },
              child: const Text('保存视频'))
        ],
      ),
    );
  }

  // 动态申请权限，ios 要在info.plist 上面添加
  /// 动态申请权限，需要区分android和ios，很多时候它两配置权限时各自的名称不同
  /// 此处以保存图片需要的配置为例
  Future<bool> requestPermission() async {
    late PermissionStatus status;
    // 1、读取系统权限的弹框
    if (Platform.isIOS) {
      status = await Permission.photosAddOnly.request();
    } else {
      status = await Permission.storage.request();
    }
    // 2、假如你点not allow后，下次点击不会在出现系统权限的弹框（系统权限的弹框只会出现一次），
    // 这时候需要你自己写一个弹框，然后去打开app权限的页面
    if (status != PermissionStatus.granted) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('You need to grant album permissions'),
              content: const Text(
                  'Please go to your mobile phone to set the permission to open the corresponding album'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('cancle'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('confirm'),
                  onPressed: () {
                    Navigator.pop(context);
                    // 打开手机上该app权限的页面
                    openAppSettings();
                  },
                ),
              ],
            );
          });
    } else {
      return true;
    }
    return false;
  }

  // 保存图片的权限校验
  checkPermission(Future<dynamic> fun) async {
    bool mark = await requestPermission();
    mark ? fun : null;
  }

  // 保存APP里的图片
  saveAssetsImg() async {
    RenderRepaintBoundary boundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
    await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result =
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      if (result['isSuccess']) {
        EasyLoading.showToast("保存APP里的图片成功");
      } else {
        EasyLoading.showToast("保存网络图片失败");
      }
    }
  }

  // 保存网络图片
  saveNetworkImg(String imgUrl) async {
    var response = await Dio()
        .get(imgUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100);
    if (result['isSuccess']) {
      EasyLoading.showToast("保存网络图片成功");
    } else {
      EasyLoading.showToast("保存网络图片失败");
    }
  }

  // 保存gif动画
  savegif(String imgUrl) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.gif";
    String fileUrl = imgUrl;
    await Dio().download(fileUrl, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    if (result['isSuccess']) {
      EasyLoading.showToast("保存gif动画成功");
    } else {
      EasyLoading.showToast("保存网络图片失败");
    }
  }

  // 保存视频
  saveVideo() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";
    String fileUrl = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
      print((count / total * 100).toStringAsFixed(0) + "%");
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    if (result['isSuccess']) {
      EasyLoading.showToast("保存视频成功");
    } else {
      EasyLoading.showToast("保存网络图片失败");
    }
  }
}
