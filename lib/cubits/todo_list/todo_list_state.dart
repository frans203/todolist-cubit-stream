part of "todo_list_cubit.dart";

class TodoListState extends Equatable {
  final List<Todo> todos;
  TodoListState({required this.todos});

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todo(desc: "todo desc1", id: "1"),
      Todo(desc: "todo desc2", id: "2"),
      Todo(desc: "todo desc3", id: "3"),
    ]);
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'TodoListState{todos: $todos}';
  }

  TodoListState copyWith({List<Todo>? todos}) {
    return TodoListState(todos: todos ?? this.todos);
  }
}
