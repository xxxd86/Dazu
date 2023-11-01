import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ThreeDpage extends StatelessWidget {
  const ThreeDpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Model Viewer')),
        body: const ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: 'assets/bhuda_stone.glb',
          alt: 'A 3D model of an astronaut',
          ar: true,
          // autoRotate: true,
          disableTap:false,
           arModes: [],
          // iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
          cameraControls: true,
          autoPlay: true,

        ),
      ),
    );
  }
}