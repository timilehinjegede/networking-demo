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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name: ${snapshot.data[index].name}',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,),
                        ),
                        SizedBox(height: 2,),
                        Text(
                            'Email: ${snapshot.data[index].email}',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,),
                        ),
                        SizedBox(height: 8,),
                        Text(
                            'Body: ${snapshot.data[index].body}',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: Colors.grey,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,),
                          child: Divider(color: Colors.grey,),
                        ),
                      ],
                    ),
                  );
              },
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text(
                '${snapshot.error}'
              ),
            );
          }
          return LoadingIndicator();
        }
      )
    );
  }
}
