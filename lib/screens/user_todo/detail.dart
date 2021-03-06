import 'package:flutter/material.dart';
import 'package:networkingdemo/api/api_service.dart';
import 'package:networkingdemo/components/loading_indicator.dart';
import 'package:networkingdemo/models/todo.dart';

class UserTodoDetail extends StatefulWidget {
  final int id;

  UserTodoDetail(this.id);

  @override
  _UserTodoDetailState createState() => _UserTodoDetailState();
}

class _UserTodoDetailState extends State<UserTodoDetail> {
  Future<List<Todo>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = ApiService.fetchTodos(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos of User ${widget.id}'),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Todo>>(
          future: futureTodos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Text: ${snapshot.data[index].title}'),
                        subtitle: Text(
                          'Completed: ${snapshot.data[index].completed}',
                        ),
                        isThreeLine: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
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
              return Text('${snapshot.error}');
            }
            return LoadingIndicator();
          }),
    );
  }
}
