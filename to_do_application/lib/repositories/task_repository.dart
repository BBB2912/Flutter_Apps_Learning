import 'package:to_do_application/models/task.dart';

class TaskRepository {
  final List<Task> _tasks=[
    Task(id: '1', title: 'Buy groceries', description: 'Milk, Bread, Eggs', status: true),
    Task(id: '2', title: 'Walk the dog', description: 'Evening walk in the park', status: false),
    Task(id: '3', title: 'Read a book', description: 'Finish reading "Flutter for Beginners"', status: false),
  ];

  List<Task> getAllTasks(){
    return _tasks;
  }

  void addTask(Task task){
    _tasks.add(task);
  }

  void updateTask(Task task){
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  void deleteTask(String id){
    _tasks.removeWhere((task) => task.id == id);
  }
  
}