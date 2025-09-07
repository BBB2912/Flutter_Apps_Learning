import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/models/task.dart';
import 'package:to_do_application/providers/task_provider.dart';


class TaskItem extends StatelessWidget {

  final Task task;
  const TaskItem({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    final TaskProvider taskProvider=Provider.of<TaskProvider>(context,listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.all(16),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[800],
      ),
      child: ListTile(
        minTileHeight:40,
        leading: Transform.scale(
          scale: 1.5,
          child: Checkbox(
            value: task.status ?? false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              
            ),
            onChanged: (_){
              taskProvider.updateTask(task.copyWith(status: !(task.status ?? false)));
            },
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(WidgetState.selected)) {
          return Colors.redAccent; // fill when checked
                }
                return Colors.black; // border color when unchecked
              },
            ),
            checkColor: Colors.white, // tick color when checked
          ),
        ),
        title: Text(
          task.title ?? "No Title",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          task.description ?? "No Description",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            taskProvider.deleteTask(task.id!);
          },
      ),
      )
    );
  }
}