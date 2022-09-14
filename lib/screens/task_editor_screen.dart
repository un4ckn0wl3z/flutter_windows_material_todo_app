import 'package:flutter/material.dart';
import 'package:flutter_material_todo_app/main.dart';
import 'package:flutter_material_todo_app/models/task_model.dart';
import 'package:flutter_material_todo_app/objectbox.g.dart';

class TaskEditorScreen extends StatefulWidget {
  const TaskEditorScreen({Key? key}) : super(key: key);

  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  Box<TodoEntity> taskBox = objectBox.store.box<TodoEntity>();
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0.0,
        title: const Text("Create a new Task"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Task Title",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _taskTitleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.black12,
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.white12),
                  hintText: "Type your Task Title eg: Buy some Milk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Task Description",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _taskDescController,
                style: const TextStyle(color: Colors.white),
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  fillColor: Colors.black12,
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.white12),
                  hintText: "Type you Task description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    elevation: 0.0,
                    onPressed: () {
                      String taskTitle = _taskTitleController.text;
                      String taskDesc = _taskDescController.text;
                      TodoEntity model = TodoEntity(
                          taskTitle: taskTitle,
                          taskDescription: taskDesc,
                          creationDate: DateTime.now());
                      taskBox.put(model);
                      Navigator.pop(context);
                    },
                    color: Colors.blueAccent,
                    child: const Text("Save Task"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
