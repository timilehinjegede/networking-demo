import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:networkingdemo/api/api_service.dart';
import 'package:networkingdemo/models/photo.dart';
import 'package:http/http.dart' as http;

class AlbumPhotoDetail extends StatefulWidget {
  final int id;
  AlbumPhotoDetail(this.id);

  @override
  _AlbumPhotoDetailState createState() => _AlbumPhotoDetailState();
}

class _AlbumPhotoDetailState extends State<AlbumPhotoDetail> {
  Future<List<Photo>> futurePhoto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePhoto = ApiService.fetchPhotosWithId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos of Album ${widget.id}'),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Photo>>(
        future: futurePhoto,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        snapshot.data[index].url,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          snapshot.data[index].title,
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
          return SpinKitSquareCircle(
            color: Colors.blue,
            size: 50,
          );
          print('Here');
        },
      ),
    );
  }
}
