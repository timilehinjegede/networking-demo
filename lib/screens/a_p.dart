import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:networkingdemo/models/album.dart';

class APScreen extends StatefulWidget {
  @override
  _APScreenState createState() => _APScreenState();
}

class _APScreenState extends State<APScreen> {
  Future<Album> futureAlbum;
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: FutureBuilder(
            future: futureAlbum,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 5,
                    itemBuilder: (BuildContext context, int index){
                      return Text(
                          snapshot.data.title,
                      );
                    }
                );
              }
              }
              else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return CircularProgressIndicator();
            },
          ),

        ),
      ),
    );
  }

  Future<Album> fetchAlbums() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums');

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
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