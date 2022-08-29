import 'package:flutter/material.dart';
import '../../utils/screen_utils/custom_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:todo_app/src/ui/shared/todo_config_item.dart';
import 'package:todo_app/src/ui/theme/theme.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSeleted;
  const CustomDatePicker({
    required this.initialDate,
    required this.onDateSeleted,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void onPressed() async {
    final seletedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
      builder: (context, child) {
        return AppTheme.dialogTheme(child as Widget);
      },
    );

    setState(() {
      _selectedDate = seletedDate ?? widget.initialDate;
    });
    widget.onDateSeleted(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return TodoConfigItem(
      title: "Due date",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat("dd MMM yyyy").format(_selectedDate),
            style: TextStyle(fontSize: 16.sp),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.calendar_today_outlined,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
