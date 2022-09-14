import 'package:flutter/material.dart';
import 'package:flutter_material_todo_app/models/task_model.dart';

import '../main.dart';
import '../objectbox.g.dart';

class TaskWidget extends StatefulWidget {
  TodoEntity task;

  TaskWidget(this.task, {Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  Box<TodoEntity> taskBox = objectBox.store.box<TodoEntity>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Checkbox(
              hoverColor: Colors.white,
              value: widget.task.taskDone,
              onChanged: (value) {
                widget.task.taskDone = !widget.task.taskDone;
                taskBox.put(widget.task);
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              widget.task.taskTitle!,
              style: const TextStyle(color: Colors.white, fontSize: 24.0),
            ),
          ),
          Expanded(
              flex: 5,
              child: IconButton(
                  onPressed: () {
                    taskBox.remove(widget.task.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )))
        ],
      ),
    );
  }
}

// https://youtu.be/GRIkCODKQJ8