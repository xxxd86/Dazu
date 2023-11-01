import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dazu/controller/vedioController.dart';
import 'package:dazu/main.dart';
import 'package:dazu/model/ViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tapped/tapped.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;
import '../style/style.dart';
var isVedio = false;
var C_Camera = true;
var C_Vedio = false;
var C_Text = false;
var vedio_start = -1;
late CameraController _Cameracontroller;
enum className {
   camera(choose:false),
   vedio(choose:false),
   text(choose:false);
   const className({required this.choose});
   final bool choose;
}
final GlobalKey _globalKey = GlobalKey();
bool isInitalize = false;
List<Widget> list= [
Icon(Icons.access_alarm,size: 200,),
Icon(Icons.camera_alt,size: 200,)
];
/// 录屏
/// 录制视频
Future<void> startVideoRecording(CameraController controller) async {
  print('startVideoRecording');
  if (!controller.value.isInitialized) {
  }
  // _isRecording.value = true;
  // startCountdownTimer(); /// 这里为我统计的录制时长

  if (controller.value.isRecordingVideo) {
    return; /// 如果正在录制则无效
  }
  try {
    await controller.startVideoRecording(); /// 开始录制，会卡一下
  } on CameraException catch (e) {
    print(e);
  }
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,

  });
  CameraController getController(){
    return _Cameracontroller;
  }

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {

  late Future<void> _initializeCameraControllerFuture;
  // late Future<void>  _initializeVideoPlayerFuture;
  //
  // late VideoPlayerController _Vediocontroller;
  /// 翻转摄像头
  Future<void> onCameraSwitch() async {
    final CameraDescription cameraDescription =
    (_Cameracontroller.description == cameras[0]) ? cameras[1] : cameras[0];
    // if(_Cameracontroller.value.isInitialized){
    //   try{
    //     await _Cameracontroller.dispose();
    //   }on CameraException catch (e) {
    //     // toastShow(e);
    //     print("watswro");
    //   }
    //
    // }
    _Cameracontroller = CameraController(cameraDescription, ResolutionPreset.medium);
      try{
        await _Cameracontroller.initialize();
    } on CameraException catch (e) {
      // toastShow(e);
      print("watswro");
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _Cameracontroller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // _Vediocontroller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //   ),
    // );
    isInitalize = true;
    // Next, initialize the controller. This returns a Future.
    _initializeCameraControllerFuture = _Cameracontroller.initialize();
     // _initializeVideoPlayerFuture = _Vediocontroller.initialize();

    // _testRecordTheScreen =
    //设置监听
  }


  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _Cameracontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // padding: EdgeInsets.only(bottom: 12),
      alignment: Alignment.center,

      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      children: [
        FutureBuilder<void>(
          // future: isVedio?_initializeVideoPlayerFuture:_initializeCameraControllerFuture,
          future:_initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              // return isVedio? AspectRatio(
              //   aspectRatio: _Vediocontroller.value.aspectRatio,
              //   // Use the VideoPlayer widget to display the video.
              //   child: VideoPlayer(_Vediocontroller),
              // ):CameraPreview(_Cameracontroller);
              return CameraPreview(_Cameracontroller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(top: 600),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            //需要实现跳转内部数据变化
            children: <Widget>[
              _PointSelectTextButton(C_Camera, '拍摄',onTap:()  {
                setState(() {
                  if(C_Camera==false){
                    C_Camera =true;
                    C_Vedio=false;
                    C_Text = false;
                  }

                });
                print("这是拍摄");
              }),
              _PointSelectTextButton(C_Vedio, '视频',onTap:(){
                setState(() {
                  if(C_Vedio==false){
                    C_Vedio =true;
                    C_Camera=false;
                    C_Text = false;
                  }
                });
                print("这是视频");
              }),
              _PointSelectTextButton(C_Text, '文字',onTap:(){
                setState(() {
                  if(C_Text==false){
                    C_Text =true;
                    C_Camera=false;
                    C_Vedio = false;
                  }
                });
                print("这是文字");
              }),
            ],
          ),
        ),

       //点击事件
       Container(
         padding: EdgeInsets.only(bottom: 100),
         alignment: Alignment.bottomCenter,
         child:
         GestureDetector(
           // Provide an onPressed callback.
           //点击拍照
           onTap: () async {
             // Take the Picture in a try / catch block. If anything goes wrong,
             // catch the error.
             // if(!isVedio){
             //   try {
             //     // Ensure that the camera is initialized.
             //     await _initializeCameraControllerFuture;
             //
             //     // Attempt to take a picture and get the file `image`
             //     // where it was saved.
             //     final image = await _Cameracontroller.takePicture();
             //
             //     if (!mounted) return;
             //
             //     // If the picture was taken, display it on a new screen.
             //     await Navigator.of(context).push(
             //       MaterialPageRoute(
             //         builder: (context) => DisplayPictureScreen(
             //           // Pass the automatically generated path to
             //           // the DisplayPictureScreen widget.
             //           imagePath: image.path,
             //         ),
             //       ),
             //     );
             //   } catch (e) {
             //     // If an error occurs, log the error to the console.
             //     print(e);
             //   }
             // }
             // else{
             //   if (_Vediocontroller.value.isPlaying) {
             //     _Vediocontroller.pause();
             //   } else {
             //     // If the video is paused, play it.
             //     _Vediocontroller.play();
             //   }
             // }
              if(C_Camera){
                try {
                  // Ensure that the camera is initialized.
                  await _initializeCameraControllerFuture;
                  // Attempt to take a picture and get the file `image`
                  // where it was saved.

                  final image = await _Cameracontroller.takePicture();
                  if (!mounted) return;

                  // If the picture was taken, display it on a new screen.
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        // Pass the automatically generated path to
                        // the DisplayPictureScreen widget.
                        imagePath: image.path,
                      ),
                    ),
                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              }
              if(C_Vedio){
                setState(() {
                  vedio_start++;
                });
                //开始录制 vedio_start%2==0
                if(vedio_start%2==0){
                  if(_Cameracontroller.value.isRecordingVideo){
                    return;
                  }
                  try{
                    await _Cameracontroller.startVideoRecording();
                  }catch(e){
                    print(e);
                  }
                }
                //停止录制
                else{
                  if(!_Cameracontroller.value.isRecordingVideo){
                    return;
                  }
                  try{
                    XFile file = await _Cameracontroller.stopVideoRecording();
                    print(file.path);
                    //跳转
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(file: file.path,
                          // Pass the automatically generated path to
                          // the DisplayPictureScreen widget.
                        ),
                      ),
                    );
                  }catch(e){
                    print(e);
                  }
                }

                // //实现录制
                // PickedFile? image = (await ImagePicker().pickVideo(
                //     source: ImageSource.camera,
                //     maxDuration: Duration(minutes: 5)
                // )) as PickedFile?;
                // if(image != null){
                //   /// 视频绝对路径地址
                //   String path = image.path;
                //   File f = File(path);
                //   /// 文件大小，单位：B
                //   int fileSize = 0;
                //   /// 视频时长，单位：秒
                //   int seconds = 0;
                //   _controller = VideoPlayerController.file(f);
                //   _controller.initialize().then((value) {
                //     _controller.setLooping(true);
                //     seconds = _controller.value.duration.inSeconds;
                //     fileSize=f.lengthSync();
                //   });
                //   /// 视频名称
                //   var name = path.substring(path.lastIndexOf("/") + 1, path.length);
                // }
              }


           },
           //长按翻转
           onLongPress: () async{
            print("longlonglong");
            setState(() {
              isVedio = !isVedio;
            });
            //开始录像
            onCameraSwitch();
           },
           //   onLongPressStart: (LongPressStartDetails details) {
           //     print('长按在' + details.globalPosition.toString() + "位置上开始发生");
           //   },
           //   onLongPressUp: (){
           //      print("提起来");
           //   },
           //   onLongPressEnd: (LongPressEndDetails details){
           //     print('长按在' + details.globalPosition.toString() + "位置上开始结束");
           //   },
           // child: isVedio? Icon(
           //   _Vediocontroller.value.isPlaying ? Icons.pause : Icons.play_arrow,
           // ):Icon(Icons.camera_alt),
           child: isVedio?Icon(Icons.camera,size: 100,):Icon(Icons.camera_alt,size: 100)
         ),
       )

      ],
      // floatingActionButton: FloatingActionButton(
      //   // Provide an onPressed callback.
      //   onPressed: () async {
      //     // Take the Picture in a try / catch block. If anything goes wrong,
      //     // catch the error.
      //     try {
      //       // Ensure that the camera is initialized.
      //       await _initializeControllerFuture;
      //
      //       // Attempt to take a picture and get the file `image`
      //       // where it was saved.
      //       final image = await _controller.takePicture();
      //
      //       if (!mounted) return;
      //
      //       // If the picture was taken, display it on a new screen.
      //       await Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) => DisplayPictureScreen(
      //             // Pass the automatically generated path to
      //             // the DisplayPictureScreen widget.
      //             imagePath: image.path,
      //           ),
      //         ),
      //       );
      //     } catch (e) {
      //       // If an error occurs, log the error to the console.
      //       print(e);
      //     }
      //   },
      //   child: const Icon(Icons.camera_alt),
      // ),
    );
  }

}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
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
    checkPermission(Future<dynamic> fun) async {
      bool mark = await requestPermission();
      mark ? fun : null;
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        child: ListView(
          children: [
            Image.file(File(imagePath)),
            Text(imagePath,),
            RepaintBoundary(
                key: _globalKey,
                child: InkWell(
                    onTap: () {
                       checkPermission(saveAssetsImg());
                    },
                    child: Image.asset(
                      'assets/img/close.png',
                      height: 200,
                    ),
            ))
          ],
        ),
      ),
    );

  }

}


// 保存图片的权限校验

// 保存APP里的图片
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
      // EasyLoading.showToast("保存APP里的图片成功");
    } else {
      // EasyLoading.showToast("保存网络图片失败");
    }
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