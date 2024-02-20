import 'package:flutter/material.dart';

import '../../domain/entity/todo_item.dart';

Widget buildItem(ToDoItem item) {
  return Card(
    child: ListTile(
      title: Column(
        children: [
          Text("Name:${item.name}"),
          const SizedBox(height: 2),
          Text("Selling Price: ${item.estimateSellingPrice}"),
          const SizedBox(height: 2),
          Text("Buying Price: ${item.estimateBuyingPrice}")
        ],
      ),
    ),
  );
}
