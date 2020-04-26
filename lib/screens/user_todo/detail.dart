import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:networkingdemo/models/todo.dart';

class UserTodoDetail extends StatefulWidget {
  final int id;

  UserTodoDetail(this.id);

  @override
  _UserTodoDetailState createState() => _UserTodoDetailState();
}

class _UserTodoDetailState extends State<UserTodoDetail> {
  Future<List<Todo>> fetchTodos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos of User ${widget.id}'),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Todo>>(
          future: fetchTodos = fetchTodo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                    subtitle:
                        Text('Completed: ${snapshot.data[index].completed}'),
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return SpinKitSquareCircle(
              color: Colors.blue,
              size: 50,
            );
          }),
    );
  }

  Future<List<Todo>> fetchTodo() async {
    Map<String, String> queryParameters = {'userId': '${widget.id}'};

    var uri =
        Uri.https('jsonplaceholder.typicode.com', '/todos', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }
}
