import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todolist/domain/entity/todo_item.dart';
import 'package:todo/features/todolist/domain/usecase/todos_use_case.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class ToDosBloc extends Bloc<ToDosEvent, ToDosState> {

  final ToDosUseCase _todosUseCase;

  ToDosBloc(this._todosUseCase) : super(ToDosInitial()) {
    on<FetchToDos>(_fetchToDos);
  }

  _fetchToDos(ToDosEvent event, Emitter<ToDosState> emit,
  ) async {
    emit(ToDosLoading());

    try {
      final ToDos = await _todosUseCase.getToDoList();

      ToDos.fold(
            (failure) => emit(ToDosError(failure.message)),
            (trade) => emit(ToDosLoaded(trade.tradeItems!)),
      );

      //emit(ToDosLoaded(ToDos.rig));
    } catch (error) {
      emit(ToDosError(error.toString()));
    }
  }
}

