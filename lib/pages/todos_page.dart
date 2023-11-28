import 'package:flutter/material.dart';
import 'package:todo_cubit/components/CreateTodo.dart';
import 'package:todo_cubit/components/SearchFilterTodo.dart';
import 'package:todo_cubit/components/ShowTodos.dart';
import 'package:todo_cubit/components/TodoHeader.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              children: [
                TodoHeader(),
                CreateTodo(),
                SearchFilterTodo(),
                ShowTodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
