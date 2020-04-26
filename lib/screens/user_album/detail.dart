import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:networkingdemo/models/album.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAlbumDetail extends StatefulWidget {
  final int id;

  UserAlbumDetail(this.id);

  @override
  _UserAlbumDetailState createState() => _UserAlbumDetailState();
}

class _UserAlbumDetailState extends State<UserAlbumDetail> {

  Future<List<Album>> futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums of User ${widget.id}'),
        centerTitle: false,
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbum = fetchAlbum(),
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
            return SpinKitSquareCircle(color: Colors.blue, size: 50);
          },
        ),
      ),
    );
  }

  Future<List<Album>> fetchAlbum() async {
    Map<String, String> queryParameters = {'userId': '${widget.id}'};

    var uri =
        Uri.https('jsonplaceholder.typicode.com', '/albums', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }
}
