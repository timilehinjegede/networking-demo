import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:networkingdemo/models/comment.dart';

class PostCommentDetail extends StatefulWidget {

  final int id;

  PostCommentDetail(this.id);

  @override
  _PostCommentDetailState createState() => _PostCommentDetailState();
}

class _PostCommentDetailState extends State<PostCommentDetail> {

  Future<List<Comment>> futureComment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments on Post ${widget.id}'
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Comment>>(
        future: futureComment = fetchComments(),
        builder: (context, snapshot){
          if( snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'name: ${snapshot.data[index].name}'
                      ),
                      Text(
                          'email: ${snapshot.data[index].email}'
                      ),
                      Text(
                          'body: ${snapshot.data[index].body}'
                      ),
                      Divider(),
                    ],
                  );
              },
            );
          } else if (snapshot.hasError) {
            Text(
              '${snapshot.error}'
            );
          }
          return SpinKitSquareCircle(
            color: Colors.blue,
            size: 50,
          );
        }
      )
    );
  }

  Future<List<Comment>> fetchComments() async {
    Map<String, String> queryParameters = {'postId': '${widget.id}'};

    var uri =
    Uri.https('jsonplaceholder.typicode.com', '/comments', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('failed to load comment');
    }
  }
}
