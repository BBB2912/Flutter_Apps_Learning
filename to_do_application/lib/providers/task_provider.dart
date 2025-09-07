import 'package:flutter/material.dart';
import 'package:to_do_application/models/task.dart';
import 'package:to_do_application/repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier{
  final TaskRepository _taskRepository=TaskRepository();

  List<Task> get tasks=>_taskRepository.getAllTasks();

  void addTask(Task task){
    _taskRepository.addTask(task);
    notifyListeners();
  }

  void updateTask(Task task){
    _taskRepository.updateTask(task);
    notifyListeners();
  }

  void deleteTask(String id){
    _taskRepository.deleteTask(id);
    notifyListeners();
  }
}