import 'package:dartz/dartz.dart';
import 'package:todo/features/todolist/domain/entity/todo_item.dart';

import '../../../../core/core_export.dart';
import '../repo/todo_repository.dart';


class ToDosUseCase {
  final ToDoRepository _todoRepository;

  ToDosUseCase(this._todoRepository);

  Future<Either<Failure, ToDoItemList>> getToDoList() async {
    return await _todoRepository.getToDoList();
  }

  Future<Either<Failure, bool>> doFilterTradeList() {
    throw UnimplementedError();
  }
}
