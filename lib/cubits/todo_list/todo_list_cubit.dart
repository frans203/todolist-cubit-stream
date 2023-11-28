import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:todo_cubit/models/todo_model.dart";

part "todo_list_state.dart";

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc) {
    final newTodo = new Todo(desc: todoDesc);
    final newTodos = [...state.todos, newTodo];

    emit(state.copyWith(todos: newTodos));
    print(state);
  }

  void updateTodo(String id, String newDesc) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(completed: todo.completed, id: todo.id, desc: newDesc);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: todo.id, completed: !todo.completed, desc: todo.desc);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void removeTodo(Todo todo) {
    final newTodos =
        state.todos.where((Todo item) => todo.id != item.id).toList();
    emit(state.copyWith(todos: newTodos));
  }
}
