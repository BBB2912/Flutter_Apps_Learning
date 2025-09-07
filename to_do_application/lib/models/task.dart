class Task{
  String? id;
  String? title;
  String? description;
  bool? status;
  
  Task({this.id, this.title, this.description, this.status});

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}