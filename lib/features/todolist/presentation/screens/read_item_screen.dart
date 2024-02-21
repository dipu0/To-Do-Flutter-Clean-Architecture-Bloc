import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/todo_item.dart';
import '../bloc/todos_bloc.dart';

class ReadItemScreen extends StatelessWidget {
  final ToDoItem item;

  const ReadItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${item.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Description: ${item.description}'),
            SizedBox(height: 10),
            Text('Created: ${item.created}'),
            SizedBox(height: 10),
            Text('Completed: ${item.complete! ? 'Yes' : 'No'}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToUpdate(context, item),
                  child: Text('Update'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _confirmDelete(context, item),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToUpdate(BuildContext context, ToDoItem item) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => UpdateItemScreen(item: item),
    //   ),
    // );
  }

  void _confirmDelete(BuildContext context, ToDoItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteItem(context, item);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, ToDoItem item) {
    // Dispatch delete event to Bloc
    context.read<ToDosBloc>().add(DeleteToDoItem(item.id.toString()));
    Navigator.of(context).pop(); // Close the detail screen after deletion
  }
}
