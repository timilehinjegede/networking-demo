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
    // TODO: implement initState
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
                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(snapshot.data[index].title),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
