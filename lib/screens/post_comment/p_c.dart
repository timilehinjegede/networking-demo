import 'package:flutter/material.dart';
import 'package:networkingdemo/api/api_service.dart';
import 'package:networkingdemo/components/loading_indicator.dart';
import 'package:networkingdemo/models/post.dart';
import 'package:networkingdemo/screens/post_comment/detail.dart';

class PCScreen extends StatefulWidget {
  @override
  _PCScreenState createState() => _PCScreenState();
}

class _PCScreenState extends State<PCScreen> {
  Future<List<Post>> futurePosts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePosts = ApiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Posts',
            ),
            centerTitle: false),
        body: FutureBuilder<List<Post>>(
            future: futurePosts,
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
              return LoadingIndicator();
            }));
  }
}
