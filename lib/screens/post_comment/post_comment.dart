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
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PostCommentDetail(
                              snapshot.data[index].id,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        'Title: ${snapshot.data[index].title}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Body: ${snapshot.data[index].body}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text(
                '${snapshot.error}',
              ),
            );
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
