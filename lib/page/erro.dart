// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image Picker Demo',
      home: MyHomePage(title: 'Image Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<XFile>? imageList;
  XFile? video;
  late Uint8List bytes;
// 使用ImagePicker前必须先实例化
  final ImagePicker _imagePicker = ImagePicker();
  selectImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    bytes = (await image?.readAsBytes())!;
    setState(() {

    });
    print(bytes);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(onPressed: (){
        try{
          selectImage();
        }catch(e){
          print("realy errro");
        }

      },),
    );
  }
}

