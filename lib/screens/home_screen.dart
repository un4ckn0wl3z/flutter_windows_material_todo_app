import 'package:flutter/material.dart';
import 'package:flutter_material_todo_app/screens/task_editor_screen.dart';
import 'package:flutter_material_todo_app/widgets/task_widget.dart';

import '../main.dart';
import '../models/task_model.dart';
import '../objectbox.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<TodoEntity>? taskBox;
  Stream<List<TodoEntity>>? fetchAllTasks;

  @override
  void initState() {
    super.initState();
    taskBox = objectBox.store.box<TodoEntity>();
    setState(() {
      fetchAllTasks =
          taskBox!.query().watch(triggerImmediately: true).map((event) {
        return event.find();
      });
    });
  }

  @override
  void dispose() {
    objectBox.store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "👏 Welcome Sir",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Todo's Tasks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TaskEditorScreen()));
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add a new Task"))
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              StreamBuilder<List<TodoEntity>>(
                  stream: fetchAllTasks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            children: snapshot.data!
                                .map((e) => TaskWidget(e))
                                .toList(),
                          ),
                        );
                      }
                    }
                    return const Center();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
