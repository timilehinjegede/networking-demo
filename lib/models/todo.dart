class Todo {
  final String title;
  final bool completed;

  Todo({this.title, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json['title'],
        completed: json['completed'],
      );
}
