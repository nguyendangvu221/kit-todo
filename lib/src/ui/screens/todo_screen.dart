import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/src/resources/data/models.dart';
import 'package:todo_app/src/ui/providers/providers.dart';
import 'package:todo_app/src/ui/shared/components.dart';
import 'package:todo_app/src/utils/screen_utils/custom_screenutil.dart';

class TodoScreen extends StatelessWidget {
  final Todo? originalTodo;
  final bool isUpdating;
  final TodoScreenManager _manager;
  TodoScreen({
    Key? key,
    this.originalTodo,
    required this.isUpdating,
  })  : _manager = TodoScreenManager(originalTodo),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _manager,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: _buildBottomButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text(isUpdating ? "Edit Task" : "Add Task"),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<TodoScreenManager>(
      builder: (context, manager, child) {
        final _nameController = TextEditingController()
          ..text = manager.currentTodo.name;
        _nameController.addListener(() {
          manager.upDateTodoName(_nameController.text);
        });
        return ListView(
          padding: EdgeInsets.only(
            top: 14.h,
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
          ),
          children: [
            TodoConfigItem(
              title: "Task name",
              contentBottomPadding: 8.h,
              contentTopPadding: 8.h,
              child: TextField(
                controller: _nameController,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: "Enter todo name",
                  hintStyle: const TextStyle(
                    color: Color(0xffeeeeee),
                  ),
                  errorText: manager.errorText,
                ),
              ),
            ),
            CustomColorPicker(
              initalColor: manager.currentTodo.color,
              onColorSelected: manager.updateColor,
            ),
            CustomDatePicker(
              initialDate: manager.currentTodo.dueDate,
              onDateSeleted: manager.updateDueDate,
            ),
            CustomTimePicker(
              initialTime: manager.currentTodo.dueTime,
              onTimeSelected: manager.updateDueTime,
            ),
            CustomLevelSelect(
              initialLevel: manager.currentTodo.level,
              onLevelSelected: manager.updateLevel,
            ),
          ],
        );
      },
    );
  }

  SizedBox _buildBottomButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Consumer<TodoScreenManager>(builder: (context, manager, _) {
          return TextButton(
            child: Text(isUpdating ? "Save Task" : "Add Task"),
            onPressed: () {
              if (manager.validateTaskConfig()) {
                final newTodo = manager.currentTodo;
                final todoManager =
                    Provider.of<TodoManager>(context, listen: false);
                if (isUpdating) {
                  todoManager.upDateTodo(originalTodo!.id, newTodo);
                } else {
                  todoManager.addTodo(newTodo);
                }
                Navigator.pop(context);
              }
            },
          );
        }),
      ),
    );
  }
}
