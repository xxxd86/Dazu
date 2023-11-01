
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<XFile>? imageList;
    XFile? video;
    late Uint8List bytes;
// 使用ImagePicker前必须先实例化
    final ImagePicker _imagePicker = ImagePicker();
    selectImage() async {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      bytes = (await image?.readAsBytes())!;

      print(bytes);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
          child: ListView(
            children: [
              ElevatedButton(
                onPressed: () => context.go('/details'),
                child: const Text('Go to the Details screen'),
              ),
              FloatingActionButton(onPressed: (){

              })
            ],
          )
      ),
    );
  }
}