import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';

class EmptyCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imgAsset;
  final String? imgText;
  final VoidCallback? callback;
  const EmptyCard({
    Key? key,
    this.width,
    this.height, this.imgAsset, this.imgText, this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
            children:[
              Center(
                child:
                Image.asset(imgAsset!,width: 30,height: 30,),
              ),
              Text(imgText!)]
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: Offset(0.0, 4.0),

            ),
          ],

        ),
      ),
      onTap: callback,
    );

  }
}
