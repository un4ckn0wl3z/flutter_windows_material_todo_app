// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:objectbox/objectbox.dart';

@Entity()
class TodoEntity {
  @Id()
  int id = 0;

  String? taskTitle;
  String? taskDescription;
  bool taskDone = false;
  DateTime? creationDate;

  TodoEntity({
    this.taskTitle,
    this.taskDescription,
    this.creationDate,
  });
}
