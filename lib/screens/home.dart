import 'package:flutter/material.dart';
import 'package:networkingdemo/components/griditem.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Networking\nDemo',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 30
              ),
            ),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: <Widget>[
                  GestureDetector(
                    child: GridItem(
                      name0: 'Albums',
                      name1: 'Photos',
                      hasThirdName: false,
                      name2: '',
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/ap');
                    },
                  ),
                  GestureDetector(
                    child: GridItem(
                      name0: 'Post',
                      name1: 'Comments',
                      hasThirdName: false,
                      name2: '',
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/pc');
                    },
                  ),
                  GestureDetector(
                    child: GridItem(
                      name0: 'Users',
                      name1: 'Todos',
                      hasThirdName: false,
                      name2: '',
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/ut');
                    },
                  ),
                  GestureDetector(
                    child: GridItem(
                      name0: 'Users',
                      name1: 'Albums',
                      hasThirdName: false,
                      name2: '',
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/ua');
                    },
                  ),
                  GestureDetector(
                    child: GridItem(
                      name0: 'Users',
                      name1: 'Albums',
                      name2: 'Photos',
                      hasThirdName: true,
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/uap');
                    },
                  ),
                  GestureDetector(
                    child: GridItem(
                      name0: 'Users',
                      name1: 'Posts',
                      name2: 'Comments',
                      hasThirdName: true,
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/upc');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
