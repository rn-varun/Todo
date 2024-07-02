import "package:hive_flutter/hive_flutter.dart";

class TodoDatabase{
  List todoList = [];

  final _myBox = Hive.box('Todo');

  void createInitialData() {
    todoList = [
      ['Do Exercise', false],
      ['Code', false]
    ];
  }

  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  void updateData(){
    _myBox.put('TODOLIST', todoList);
  }
}