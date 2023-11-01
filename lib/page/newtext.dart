import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dazu/main.dart';
import 'package:image_picker/image_picker.dart';

import 'ee.dart';
main(){
  runApp(SplitImage());
}
class SplitImage extends StatefulWidget {
  @override
  _SplitImageState createState() => _SplitImageState();
}

class _SplitImageState extends State<SplitImage> {
// ImagePicker获取内容后返回的对象是XFile

  List<XFile>? imageList;
  XFile? video;
   Uint8List bytes = Uint8List(0);
// 使用ImagePicker前必须先实例化
  final ImagePicker _imagePicker = ImagePicker();
  var clipCount = 4 ;
  bool assets = false;
  @override
  void initState() {
    super.initState();
    splitImages.clear();

  }

  Future<void> splitImage() async {

      var imageBytes = assets?(await rootBundle.load('assets/hello.jpg')).buffer.asUint8List():bytes;
    final originalImage = await decodeImageFromList(imageBytes);

    final width = originalImage.width ~/ clipCount;
    final height = originalImage.height ~/ clipCount;

    for (int i = 0; i < clipCount*clipCount; i++) {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      final srcRect = Rect.fromLTWH((i % clipCount) * width.toDouble(), (i ~/ clipCount) * height.toDouble(), width.toDouble(), height.toDouble());
      final dstRect = Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble());

      canvas.drawImageRect(originalImage, srcRect, dstRect, Paint());

      final picture = recorder.endRecording();
      final image = await picture.toImage(width, height);
      final splitImageBytes = await image.toByteData(format: ui.ImageByteFormat.png);

      setState(() {
        splitImages.add(splitImageBytes!.buffer.asUint8List());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    selectImage() async {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      bytes = (await image?.readAsBytes())!;
      fulldata = bytes;
      splitImage();
      setState(() {

      });

      print(bytes);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Split Image'),
      ),
      body: Container(
        height: 400,
        color: Colors.redAccent,
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: clipCount,
              ),
              itemCount: splitImages.length,
              itemBuilder: (context, index) {
                return Image.memory(splitImages[index]);
              },
            ),
            Row(
              children: [
                FloatingActionButton(onPressed: (){
                  // 设置返回图片的其他参数
                  selectImage();


                },child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.amber,
                  child: Text("选择图片"),
                ),
                ),
                FloatingActionButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      myHomePage(title: "拼图游戏",)
                  ));

                },child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.amber,
                  child: Text("进入游戏"),
                ),
                )

              ],
            )



          ],
        )
      )
    );
  }
}
