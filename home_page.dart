import 'package:flutter/material.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final _controller = TextEditingController(); // List of todo tasks
  List<List<dynamic>> toDolist = [
    ["Make Tutorial", false],
    ["Do Exercise", false],
  ];

  //save new task
  void saveNewTask() {
    setState(() {
      toDolist.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // Method checkbox was tapped
  void checkBoxChanged(bool value, int index) {
    setState(() {
      toDolist[index][1] = !toDolist[index][1];
    });
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('To Do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDolist.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDolist[index][0],
            taskCompleted: toDolist[index][1],
            onChanged: (value) => checkBoxChanged(value!, index),
          );
        },
      ),
    );
  }
}
