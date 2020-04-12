import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {

  final String name0;
  final String name1;
  final String name2;
  final bool hasThirdName;

  final TextStyle myStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

  GridItem({this.name0, this.name1, this.name2, this.hasThirdName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue[500],
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
          ),
          Text(
            name1,
            style: myStyle,
          ),
          hasThirdName
              ? Text(
                  '&',
                )
              : SizedBox(
                  height: 0,
                ),
          hasThirdName
              ? Text(
                  name2,
                  style: myStyle,
                )
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
