import 'package:flutter/material.dart';
import '../../utils/screen_utils/custom_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/utils/constants.dart';
import '../../resources/data/models.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final Function() onCompleteTapped;
  final Function() onTapped;
  final Function(DismissDirection) onDismissed;

  const TodoCard({
    required this.todo,
    required this.onCompleteTapped,
    required this.onTapped,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat _formatDay = DateFormat("dd MMM yyyy");
    return Dismissible(
      key: GlobalKey(),
      background: Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.delete_forever_rounded,
          color: kPrimaryColor,
          size: 50.sp,
        ),
      ),
      onDismissed: onDismissed,
      child: InkWell(
        onTap: onTapped,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
            color: todo.color,
          ),
          padding: EdgeInsets.only(
            top: 18.h,
            bottom: 18.h,
            left: 23.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.name,
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            _formatDay.format(todo.dueDate).toString(),
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Row(
                        children: [
                          Icon(Icons.schedule_rounded, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            todo.dueTime.format(context),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    radius: 40.sp,
                    onTap: onCompleteTapped,
                    child: Icon(
                      todo.isComplete
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked,
                      size: 33.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
