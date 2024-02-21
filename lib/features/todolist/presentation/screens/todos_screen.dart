import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/todo_item.dart';
import '../bloc/todos_bloc.dart';

class ToDosScreen extends StatelessWidget {
  const ToDosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ToDosBloc>().add(const FetchToDos());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your ToDos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.deepPurple, // Updated color
        ),
        body: BlocConsumer<ToDosBloc, ToDosState>(
          listener: (context, state) {
            if (state is ToDosError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('An error occurred')),
              );
            }
          },
          builder: (context, state) {
            if (state is ToDosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ToDosLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ToDosBloc>().add(const FetchToDos());
                },
                child: _listView(context, state.todos),
              );
            } else {
              return const Center(child: Text('No todos found.', style: TextStyle(fontSize: 18)));
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigate to the add todo screen or show a form
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Todo'),
          backgroundColor: Colors.deepPurple, // Updated color
        ),
      ),
    );
  }

  Widget _listView(BuildContext context, List<ToDoItem> todoItems) {
    return ListView.builder(
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        final item = todoItems[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 8,
            shadowColor: Colors.deepPurpleAccent,
            child: ListTile(
              leading: Icon(Icons.check_circle_outline, color: item.complete! ? Colors.green : Colors.red),
              title: Text(item.title!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Tap for details', style: TextStyle(color: Colors.deepPurpleAccent)),
              onTap: () => _showDetailDialog(context, item),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDetailDialog(BuildContext context, ToDoItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(item.title ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Details: ${item.description}"),
                Text("Created: ${item.created}"),
                Text("Completed: ${item.complete! ? 'Yes' : 'No'}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(color: Colors.deepPurple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
