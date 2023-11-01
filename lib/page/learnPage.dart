import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'demo.dart';
import 'hero.dart';
var card =    Card(
  child: Column(
    children: [
      const ListTile(
        leading: Icon(Icons.album),
        title: Text('FAULTE'),
        subtitle: Text('FAULTE'),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed: () {}, child: Text('BUY TICKETS')),
          SizedBox(
            width: 8,
          ),
          TextButton(onPressed: () {}, child: const Text('LISTEN')),
          SizedBox(width: 8),
        ],
      )
    ],
    mainAxisSize: MainAxisSize.min,
  ),
);
class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        UserCard(),
        // HeroAnimation()
        FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HeroAnimation()));
        }),
        card,card,card

      ],
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Card View';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Card View',
        home: Scaffold(
          appBar: new AppBar(title: new Text(_title)),
          body: const MyStatelessWidget(),
        ));
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child:
      ListView(
        children: [
          card,
          card
        ],
      )

    );
  }
}