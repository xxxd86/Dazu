// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:easy_puzzle_game/easy_puzzle_game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dazu/page/erro.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
/// This sample app shows an app with two screens.
///
/// The first route '/' is mapped to [HomeScreen], and the second route
/// '/details' is mapped to [DetailsScreen].
///
/// The buttons use context.go() to navigate to each destination. On mobile
/// devices, each destination is deep-linkable and on the web, can be navigated
/// to using the address bar.
void main() => runApp(const MyApp());

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  HomeScreen();
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

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

/// The home screen
class HomeScreen extends StatefulWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {

  List<XFile>? imageList;
  XFile? video;
   Uint8List bytes = Uint8List(0);
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
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
          child: ListView(
            children: [
              ElevatedButton(
                onPressed: () => context.go('/details'),
                child: const Text('Go to Puzzle Game'),
              ),
              FloatingActionButton(onPressed: (){
                try{
                  selectImage();
                }catch(e){
                  print("realy errro");
                }
              },child: Container(
                width: 100,
                height: 100,
                color: Colors.white,
                child: bytes.isEmpty?Container():Image.memory(bytes),
              ),)
            ],
          )
      ),
    );
  }
}

/// The details screen
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();

}
class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return   EasyPuzzleGameApp(
      title: '拼图游戏',
      puzzleFullImg:
      'assets/hello.jpg',
      puzzleBlockFolderPath:
      'assets/blocks',
      puzzleRowColumn: 4,
    );
  }


}
