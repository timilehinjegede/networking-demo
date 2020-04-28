import 'dart:async';
import 'package:flutter/material.dart';
import 'package:networkingdemo/api/api_service.dart';
import 'package:networkingdemo/components/loading_indicator.dart';
import 'package:networkingdemo/models/album.dart';
import 'package:networkingdemo/screens/album_photo/detail.dart';

class APScreen extends StatefulWidget {
  @override
  _APScreenState createState() => _APScreenState();
}

class _APScreenState extends State<APScreen> {
  Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = ApiService.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Albums',
        ),
        centerTitle: false,
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AlbumPhotoDetail(
                                  snapshot.data[index].id,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            snapshot.data[index].title,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            size: 20,
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
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
