import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:networkingdemo/models/album.dart';
import 'package:networkingdemo/models/photo.dart';
import 'package:networkingdemo/screens/album_photo/detail.dart';

class APScreen extends StatefulWidget {
  @override
  _APScreenState createState() => _APScreenState();
}

class _APScreenState extends State<APScreen> {
  Future<List<Album>> futureAlbum;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Album',
        ),
        centerTitle: false,
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AlbumPhotoDetail(snapshot.data[index].id)));
                    },
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                snapshot.data[index].title,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
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
      ),
    );
  }

  Future<List<Album>> fetchAlbums() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }

  Future<Album> updateAlbum(String title) async {
    final http.Response response = await http.put(
      'https://jsonplaceholder.typicode.com/albums/1',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title}),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album');
    }
  }

  Future<Album> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      'https://jsonplaceholder.typicode.com/albums/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
    }
  }
}

//Column(children: <Widget>[
//Column(
//children: <Widget>[
//TextField(
//controller: _controller,
//),
//SizedBox(
//height: 20,
//),
//Text('${snapshot.data?.title ?? 'Deleted'}'),
//SizedBox(height: 20,),
//FlatButton(
//child: Text(
//'Update'
//),
//onPressed: (){
//setState(() {
////                            futureAlbum = deleteAlbum(snapshot.data.id);
//futureAlbum = updateAlbum(_controller.text);
//});
//},
//)
//],
//)
