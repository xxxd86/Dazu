import 'package:easy_puzzle_game/easy_puzzle_game.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class myHomePage extends StatefulWidget {
  const myHomePage({super.key, required this.title});

  final String title;

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  @override
  Widget build(BuildContext context) {
    return  EasyPuzzleGameApp(
      title: '拼图游戏',
      puzzleFullImg:
      'assets/hello.jpg',
      puzzleBlockFolderPath:
      'assets/blocks',
      puzzleRowColumn: 4,
    );
  }
}