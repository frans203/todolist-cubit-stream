import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_cubit/cubits/todo_filter/todo_filter_cubit.dart";
import "package:todo_cubit/cubits/todo_list/todo_list_cubit.dart";
import "package:todo_cubit/cubits/todo_search/todo_search_cubit.dart";
import "package:todo_cubit/models/todo_model.dart";

part "filtered_todos_state.dart";

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  late StreamSubscription todoSearchSubscription;
  late StreamSubscription todoFilterSubscription;
  late StreamSubscription todoListSubscription;
  //this is most like an unique useEffect for each cubit we got
  //we need constant info about what is happening among all this cubit states

  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  final List<Todo> initialTodos;
  FilteredTodosCubit(
      {required this.todoFilterCubit,
      required this.todoSearchCubit,
      required this.todoListCubit,
      required this.initialTodos})
      : super(FilteredTodosState(filteredTodos: initialTodos)) {
    todoFilterSubscription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });

    todoSearchSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });

    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodos = todoListCubit.state.todos
            .where((Todo todo) => !todo.completed)
            .toList();
        break;

      case Filter.completed:
        _filteredTodos = todoListCubit.state.todos
            .where((Todo todo) => todo.completed)
            .toList();
        break;

      case Filter.all:
      default:
        _filteredTodos = todoListCubit.state.todos;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoListSubscription.cancel();
    todoSearchSubscription.cancel();

    return super.close();
  }
}
