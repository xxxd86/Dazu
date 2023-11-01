import 'package:flutter/material.dart';

import 'donationPage.dart';

class CharityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("公益界面"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '欢迎参与公益活动！',
              style: TextStyle(fontSize: 24),
            ),
            MaterialButton(
              child: Text('我要捐款'),
              onPressed: () {
                // 处理捐款逻辑
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DonationPage()));
              },
            ),
            MaterialButton(
              child: Text('我要报名'),
              onPressed: () {
                // 处理报名逻辑
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DonationPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CharityPage(),
  ));
}
