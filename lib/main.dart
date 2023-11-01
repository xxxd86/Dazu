 import 'package:camera/camera.dart';
import 'package:dazu/controller/ss.dart';
import 'package:dazu/introduction_animation/introduction_animation_screen.dart';
import 'package:dazu/page/ThereDPage.dart';
import 'package:dazu/page/ee.dart';
import 'package:dazu/page/homePage.dart';
import 'package:dazu/page/newtext.dart';
import 'package:dazu/utils/PermissionUtils.dart';
import 'package:dazu/views/bottom3/bottom_3_page.dart';
import 'package:dazu/views/tabb.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
 import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
 import 'dart:io';
 late CameraDescription firstCamera;
 final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();
 late List<CameraDescription> cameras;
 late CameraController _Cameracontroller;
 late Future<void> _initializeCameraControllerFuture;
 List<Uint8List> splitImages = [];
 Uint8List fulldata = Uint8List(0);
 Future<void> main() async {
   //获取相机权限
   WidgetsFlutterBinding.ensureInitialized();

   // Obtain a list of the available cameras on the device.
   cameras = await availableCameras();

   // Get a specific camera from the list of available cameras.
   firstCamera = cameras.first;
   // 获取摄像头权限
   PermissionUtils.requestCameraPermission();
   flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
       AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
   // initLeanCloud();
   /// 自定义报错页面
   if (kReleaseMode) {
     ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
       debugPrint(flutterErrorDetails.toString());
       return Material(
         child: Center(
             child: Text(
               "发生了没有处理的错误\n请通知开发者",
               textAlign: TextAlign.center,
             )),
       );
     };
   }

   runApp(MyApp());
 }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
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
      home: homePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container()
    );
  }
}
 class HexColor extends Color {
   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

   static int _getColorFromHex(String hexColor) {
     hexColor = hexColor.toUpperCase().replaceAll('#', '');
     if (hexColor.length == 6) {
       hexColor = 'FF' + hexColor;
     }
     return int.parse(hexColor, radix: 16);
   }
 }
