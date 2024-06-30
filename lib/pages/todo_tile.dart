import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  TodoTile({super.key, required this.taskName, required this.taskCompleted, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20
          ),
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged, activeColor: Colors.red,), // pass the value and onChanged function here
              Text(taskName, style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none
              ),) // pass the task here
            ],
            ),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}