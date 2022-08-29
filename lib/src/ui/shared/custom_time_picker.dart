import 'package:flutter/material.dart';
import '../../utils/screen_utils/custom_screenutil.dart';
import 'package:todo_app/src/ui/shared/todo_config_item.dart';
import 'package:todo_app/src/ui/theme/theme.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;
  const CustomTimePicker({
    required this.initialTime,
    required this.onTimeSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay _seletedTime;

  @override
  void initState() {
    super.initState();
    _seletedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return TodoConfigItem(
      title: "Due time",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _seletedTime.format(context),
            style: TextStyle(fontSize: 16.sp),
          ),
          IconButton(
            onPressed: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, child) {
                  return AppTheme.dialogTheme(child as Widget);
                },
              );
              setState(() {
                _seletedTime = selectedTime ?? TimeOfDay.now();
                widget.onTimeSelected(_seletedTime);
              });
            },
            icon: Icon(
              Icons.schedule_rounded,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
