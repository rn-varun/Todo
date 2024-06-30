import 'package:flutter/material.dart';
import 'package:todo/pages/todo_tile.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController writeTodo =
      new TextEditingController(); // text in dialog box is here

  List _tasks = [
    ['Drink Protein Shake', true],
    ['Do Push-Ups', false],
  ];
  List<String> _completedTasks = [];

  void _addTask() {
    setState(() {
      if (writeTodo.text.isNotEmpty) {
        _tasks.add(writeTodo.text);
        writeTodo.clear();
      }
    });
  }

  void _deleteCompletedTask(int index) {
    setState(() {
      _completedTasks.removeAt(index);
    });
  }

  void _addNewTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add new task'),
            content: TextField(
              controller: writeTodo,
              decoration: InputDecoration(hintText: 'Enter new task'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (writeTodo.text.isNotEmpty) {
                      setState(() {
                        var _newTask = [writeTodo.text, false];
                        _tasks.add(_newTask);
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'))
            ],
          );
        });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _completeTask(int index) {
    setState(() {
      final completedTask = _tasks.removeAt(index);
      _completedTasks.add(completedTask);
    });
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      _tasks[index][1] = !_tasks[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        // appBar decoration

        elevation: 5.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,

        // appBar title

        title: Text(
          'DoDo',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.login),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return TodoTile(
                taskName: _tasks[index][0],
                taskCompleted: _tasks[index][1],
                onChanged: (value) => checkBoxChanged(value, index));
          }),
    );
  }
}
