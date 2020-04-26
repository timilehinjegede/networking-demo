import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:networkingdemo/models/post.dart';
import 'package:networkingdemo/screens/post_comment/detail.dart';

class PCScreen extends StatelessWidget {
  Future<List<Post>> futurePosts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Posts',
            ),
            centerTitle: false),
        body: FutureBuilder<List<Post>>(
            future: futurePosts = fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostCommentDetail(snapshot.data[index].id)));
                      },
                      child: ListTile(
                        title: Text('${snapshot.data[index].title}'),
                        subtitle: Text('${snapshot.data[index].body}'),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              } else if (snapshot.hasError) {
                Text('${snapshot.error}');
              }
              return SpinKitSquareCircle(
                color: Colors.blue,
                size: 50,
              );
            }));
  }

  Future<List<Post>> fetchPosts() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }
}
