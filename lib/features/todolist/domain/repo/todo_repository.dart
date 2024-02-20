import 'package:dartz/dartz.dart';
import 'package:todo/core/core_export.dart';

import '../entity/todo_item.dart';

abstract class ToDoRepository {
  Future<Either<Failure, ToDoItemList>> getToDoList();
}
