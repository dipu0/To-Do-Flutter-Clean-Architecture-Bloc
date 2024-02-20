part of 'todos_bloc.dart';


abstract class ToDosEvent extends Equatable {
  const ToDosEvent();
}

class FetchToDos extends ToDosEvent {
  const FetchToDos();

  @override
  List<Object> get props => [];
}