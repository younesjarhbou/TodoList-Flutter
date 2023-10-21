class Todo {
  final String id;
  final String text;
  final bool completed;
  final String createdAt;

  Todo({
    required this.id,
    required this.text,
    required this.completed,
    required this.createdAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'],
      text: json['text'],
      completed: json['completed'],
      createdAt: json['created_at'],
    );
  }
}
