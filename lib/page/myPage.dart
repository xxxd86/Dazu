import 'package:flutter/cupertino.dart';

import '../introduction_animation/introduction_animation_screen.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
     child: GestureDetector(
       onTap: (){

       },
     ),
    );
  }
}