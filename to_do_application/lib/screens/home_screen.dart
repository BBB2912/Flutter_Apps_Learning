import 'package:flutter/material.dart';
import 'package:to_do_application/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/screens/add_tasks_screen.dart';
import 'package:to_do_application/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title:Text(
          "To Do List",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body:Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
            child:tasks.isEmpty?Center(
              child:Text(
              "No tasks yet....!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ):
          ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItem(task: tasks[index]);
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
        },
      ),
    );
  }
}