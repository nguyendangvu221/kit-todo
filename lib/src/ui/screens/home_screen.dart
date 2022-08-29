import 'package:flutter/material.dart';
import 'package:todo_app/src/ui/screens/empty_screen.dart';
import '../../utils/screen_utils/custom_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/ui/providers/providers.dart';
import 'package:todo_app/src/ui/screens/todo_screen.dart';

import '../../resources/data/models.dart';
import '../../utils/constants.dart';

import '../shared/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void navigateToTodoScreen(BuildContext context, bool isUpdating,
      {Todo? originalTodo}) async {
    assert(isUpdating == false || originalTodo != null,
        "originalTodo must be provided if isUpdating is true");
    final newTodo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TodoScreen(
            isUpdating: isUpdating,
            originalTodo: originalTodo,
          );
        },
      ),
    );
    if (isUpdating && newTodo != null) {
      Provider.of<TodoManager>(context, listen: false)
          .upDateTodo(originalTodo!.id, newTodo);
    } else if (newTodo != null) {
      Provider.of<TodoManager>(context, listen: false).addTodo(newTodo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.only(
          top: 30.h,
          right: 20.w,
          left: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            SizedBox(
              height: 28.h,
            ),
            Expanded(
              child: _buildTodoTabView(context),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBottomButton(context),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: const Text("Task Manager"),
      leading: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.widgets_rounded,
            color: Colors.white,
          ),
        ),
        onTap: () {
          // TODO: Open Profile
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // TODO: Open Notification
          },
          child: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back!",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 14.h,
            ),
            Text(
              "Here's Update Today",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            // Open Search
          },
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: kPrimaryColor),
            child: const Icon(Icons.search, color: Colors.white),
            width: 50.w,
            height: 50.h,
          ),
        )
      ],
    );
  }

  Widget _buildTodoTabView(BuildContext context) {
    return Consumer<TodoManager>(
      builder: (context, snapshot, child) {
        final todos = snapshot.selectedTodos;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: Categories.values.map((e) {
                return ChoiceChip(
                  selected: e == snapshot.selectedCategory,
                  label: Text(e.toString().split(".").last),
                  onSelected: (_) {
                    snapshot.selectCategory(e);
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 23.h,
            ),
            Expanded(
              child: _buldTodoList(todos, snapshot),
            )
          ],
        );
      },
    );
  }

  Widget _buldTodoList(List<Todo> todos, TodoManager snapshot) {
    if (todos.isEmpty) {
      return const EmptyScreen();
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        return TodoCard(
          todo: todos[index],
          onTapped: () {
            navigateToTodoScreen(context, true, originalTodo: todos[index]);
          },
          onCompleteTapped: () {
            snapshot.completeTodo(todos[index], null);
          },
          onDismissed: (_) {
            snapshot.deleteTodo(todos[index]);
          },
        );
      },
      itemCount: todos.length,
      separatorBuilder: (context, _) {
        return SizedBox(
          height: 23.h,
        );
      },
    );
  }

  TextButton _buildBottomButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        navigateToTodoScreen(context, false);
      },
      icon: const Icon(Icons.add_box_rounded),
      label: const Text("Add Task"),
    );
  }
}
