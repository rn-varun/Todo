import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database/database.dart';
import 'package:todo/pages/todo_tile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('Todo');

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    // check if this is the first time the app is being opened
    // if it is, the todoList would be empty
    if(_myBox.get('TODOLIST') == null){
      db.createInitialData();
    } else {
      // data already exists
      db.loadData();
    }

    super.initState();
  }

  var _myBox = Hive.box('Todo');

  TodoDatabase db = TodoDatabase();

  TextEditingController writeTodo =
      TextEditingController(); // text in dialog box is here

  List<String> _completedTasks = [];

  void _addTask() {
    setState(() {
      if (writeTodo.text.isNotEmpty) {
        db.todoList.add(writeTodo.text);
        writeTodo.clear();
      }
    });
    db.updateData();
  }

  void _deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  void _addNewTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.yellow[200],
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 600, // Set the desired width
            height: 220, // Set the desired height
            padding: EdgeInsets.all(20), // Add padding for better layout
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add new task',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                SizedBox(height: 20),
                TextField(
                  textAlign: TextAlign.center,
                  controller: writeTodo,
                  decoration: InputDecoration(
                    hintText: 'Enter new task',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  scrollPadding: EdgeInsets.all(8),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (writeTodo.text.isNotEmpty) {
                          setState(() {
                            var _newTask = [writeTodo.text, false];
                            db.todoList.add(_newTask);
                            writeTodo.clear();
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _deleteTask(int index) {
  //   setState(() {
  //     db.todoList.removeAt(index);
  //   });
  // }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      drawer: Drawer(),
      appBar: AppBar(
        // appBar decoration

        elevation: 5.0,
        backgroundColor: Colors.yellow[200],
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
        backgroundColor: Colors.yellow[600],
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
                deleteTask: (context) => _deleteTask(index),
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index));
          }),
    );
  }
}
