import 'package:flutter/material.dart';
import 'package:networkingdemo/api/api_service.dart';
import 'package:networkingdemo/components/loading_indicator.dart';
import 'package:networkingdemo/models/album.dart';

class UserAlbumDetail extends StatefulWidget {
  final int id;

  UserAlbumDetail(this.id);

  @override
  _UserAlbumDetailState createState() => _UserAlbumDetailState();
}

class _UserAlbumDetailState extends State<UserAlbumDetail> {
  Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = ApiService.fetchAlbumsWithId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums of User ${widget.id}'),
        centerTitle: false,
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data[index].title,
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Divider(color: Colors.grey),
                      ),
                    ],
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                ),
              );
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
