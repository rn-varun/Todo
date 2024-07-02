import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  TodoTile({super.key, required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteTask});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), 
        children: [
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete,
            label: 'Delete',
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(20),
          )]),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow[400],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
              width: 1
            ),
            boxShadow:[
              BoxShadow(
                color: Colors.black.withOpacity(0),
                spreadRadius: 2,
                blurRadius: 5,
        
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(20
            ),
            child: Row(
              children: [
                Checkbox(value: taskCompleted, onChanged: onChanged, activeColor: Colors.amber,), // pass the value and onChanged function here
                Text(taskName, style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none
                ),) // pass the task here
              ],
              ),
          ),
        ),
      ),
    );
  }
}