import 'package:flutter/cupertino.dart';

class ColumeHome extends StatefulWidget {
  const ColumeHome({super.key});

  @override
  State<ColumeHome> createState() => _ColumeHomeState();
}

class _ColumeHomeState extends State<ColumeHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("data"),
            Text("data")
          ],
        ),
        Text("ss"),
        Text("ss"),
        Text("ss"),
        Text("ss"),
      ],
    );
  }
}