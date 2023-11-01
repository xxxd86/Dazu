import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TempBox extends StatelessWidget {
  const TempBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

    height: 100,
    margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 1, color: Colors.black),
    borderRadius: BorderRadius.circular(5),

    ),
    );
  }
}