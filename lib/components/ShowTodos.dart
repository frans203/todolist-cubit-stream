import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_cubit/cubits/cubits.dart";
import "package:todo_cubit/models/todo_model.dart";

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    print(todos);
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(todos[index].id),
            background: showBackground(0),
            secondaryBackground: showBackground(1),
            onDismissed: ((_) {
              context.read<TodoListCubit>().removeTodo(todos[index]);
            }),
            confirmDismiss: ((_) {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Deleting Todo"),
                      content:
                          Text("Are you sure you want to delete this todo?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text("No"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text("Yes"),
                        )
                      ],
                    );
                  });
            }),
            child: TodoItem(
              todo: todos[index],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.grey);
        },
        itemCount: todos.length);
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textController.text = widget.todo.desc;

              return StatefulBuilder(builder: (BuildContext context, setState) {
                //you need this StatefulBuilder so you can
                //grab the state of the current user's text input
                return AlertDialog(
                  title: Text("Edit Todo"),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: _error ? "Value cannot be empty" : null),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("CANCEL"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _error = textController.text.isEmpty ? true : false;
                          if (!_error) {
                            context.read<TodoListCubit>().updateTodo(widget.todo.id, textController.text);
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Text("OK"),
                    )
                  ],
                );
              });
            });
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
