import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/core_export.dart';
import '../../domain/entity/todo_item.dart';
import '../../domain/repo/todo_repository.dart';
import '../model/item_list_response.dart';

class ToDoHttpImp extends BaseHttpRepository implements ToDoRepository {
  late final ApiClient _client;
  late final ToDoApiUrls _urls;

  ToDoHttpImp(this._client, this._urls) : super(_client);

  @override
  Future<Either<Failure, ToDoItemList>> getToDoList() async {
    try {
      final response = await _client.authorizedGet(_urls.getAllToDo);
      if (response.messageCode == 200) {
        ItemListResponse itemList =
            ItemListResponse.fromJson(response.response);

        List<ToDoItem> list = [];
        for (var item in itemList.data!) {
          list.add(ToDoItem(
              title: item.title, description: item.description, complete: item.complete, created: item.created
          ));

          Logger().i(item.title);
        }

        return Right(ToDoItemList(todoItems: list));
      } else {
        return const Left(ConnectionFailure("response.data['message']"));
      }
    } catch (e) {
      throw Future.error(e);
    }
  }
}
