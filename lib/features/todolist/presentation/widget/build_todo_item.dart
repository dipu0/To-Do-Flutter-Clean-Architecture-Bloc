import 'package:flutter/material.dart';

import '../../domain/entity/todo_item.dart';

Widget buildItem(ToDoItem item) {
  return Card(
    child: ListTile(
      title: Column(
        children: [
          Text("Name:${item.title}"),
          const SizedBox(height: 2),
          Text("Details: ${item.description}"),
          const SizedBox(height: 2),
          Text("Is Complete: ${item.complete}")
        ],
      ),
    ),
  );
}
