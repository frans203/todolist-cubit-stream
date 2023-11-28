import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_cubit/components/FilterButton.dart";
import "package:todo_cubit/cubits/cubits.dart";
import "package:todo_cubit/models/todo_model.dart";
import 'package:todo_cubit/utils/debounce.dart';

class SearchFilterTodo extends StatelessWidget {
  SearchFilterTodo({super.key});
  final debounce = Debounce();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Search Todos...",
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? value) {
            if (value != null) {
              debounce.run(()  {
                context.read<TodoSearchCubit>().setSearchTerm(value);
              });
            }
          },
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterButton(filter: Filter.all),
            FilterButton(filter: Filter.active),
            FilterButton(filter: Filter.completed),
          ],
        )
      ],
    );
  }
}
