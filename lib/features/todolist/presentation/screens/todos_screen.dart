
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/todo_item.dart';
import '../bloc/todos_bloc.dart';
import '../widget/build_todo_item.dart';

class ToDosScreen extends StatelessWidget {
  const ToDosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ToDosBloc>().add(const FetchToDos());

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ToDosBloc, ToDosState>(
          listener: (context, state) {
            if (state is ToDosError) {
              // Show error message
            }
          },
          builder: (context, state) {
            if (state is ToDosLoading) {
              return const CircularProgressIndicator();
            } else if (state is ToDosLoaded) {
              return _listView(state.todos);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _listView(List<ToDoItem> todoItems) {
    // List<TradeItem> tradeItems = generateTradeItems();
    return ListView.builder(
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: buildItem(todoItems[index]),
        );
      },
    );
  }
}

