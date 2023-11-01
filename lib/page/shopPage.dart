import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flukit/flukit.dart';

import '../design_course/home_design_course.dart';
class shopPage extends StatefulWidget {
  const shopPage({super.key});

  @override
  State<shopPage> createState() => _shopPageState();
}

class _shopPageState extends State<shopPage> {
  @override
  Widget build(BuildContext context) {
    return  DesignCourseHomeScreen();
  }
}