import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  final _titleController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                final newTask = Task(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                );
                taskProvider.addTask(newTask);
                Navigator.pop(context);  // Go back to home
              },
            ),
          ],
        ),
      ),
    );
  }
}
