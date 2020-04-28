import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {

  final String name0;
  final String name1;

  final TextStyle myStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white,);

  GridItem({this.name0, this.name1,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue,
      ),
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name0,
            style: myStyle,
          ),
          Text(
            '&',
            style: TextStyle(color: Colors.white,),
          ),
          Text(
            name1,
            style: myStyle,
          ),
        ],
      ),
    );
  }
}
