import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_cubit/cubits/cubits.dart";
import "package:todo_cubit/models/todo_model.dart";

class FilterButton extends StatefulWidget {
  final Filter filter;
  late final String title;
  FilterButton({required this.filter}) {
    switch (filter) {
      case Filter.all:
        title = "All";
        break;
      case Filter.completed:
        title = "Completed";
        break;
      case Filter.active:
        title = "Active";
        break;
    }
  }

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    Color setTextColor() {
      final currentFilter = context.watch<TodoFilterCubit>().state.filter;
      return widget.filter == currentFilter ? Colors.blue : Colors.grey;
    }

    return TextButton(
      onPressed: () {
        context.read<TodoFilterCubit>().changeFilter(widget.filter);
      },
      child: Text(widget.title, style: TextStyle(color: setTextColor())),
    );
  }
}
