import 'package:flutter/material.dart';
import 'package:networkingdemo/api/api_service.dart';
import 'package:networkingdemo/components/loading_indicator.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    futureComment = ApiService.fetchCommentsWithId(widget.id);
  }

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
        future: futureComment,
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
          return LoadingIndicator();
        }
      )
    );
  }
}
