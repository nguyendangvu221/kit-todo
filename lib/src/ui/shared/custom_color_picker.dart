import 'package:flutter/material.dart';
import '../../utils/screen_utils/custom_screenutil.dart';
import 'package:todo_app/src/ui/shared/todo_config_item.dart';
import 'package:todo_app/src/ui/theme/theme.dart';

import 'dart:math';
import '../../utils/constants.dart';

bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
  int v = sqrt(pow(backgroundColor.red, 2) * 0.299 +
          pow(backgroundColor.green, 2) * 0.587 +
          pow(backgroundColor.blue, 2) * 0.114)
      .round();
  return v < 130 + bias ? true : false;
}

const List<Color> _defaultColors = [
  Color(0xfffce4ec),
  Color(0xffffebee),
  Color(0xfff3e5f5),
  Color(0xffede7f6),
  Color(0xffc5cae9),
  Color(0xffbbdefb),
  Color(0xffb3e6fc),
  Color(0xffb2ebf2),
  Color(0xffb2dfdb),
  Color(0xffc8e6c9),
  Color(0xffdcedc8),
  Color(0xfff0f4c3),
  Color(0xfffff9c4),
  Color(0xffffecb3),
  Color(0xffffe0b2),
];

typedef PickerItem = Widget Function(Color color);

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<Color> colors, PickerItem child);

typedef PickerItemBuilder = Widget Function(
    Color color, bool isCurrentColor, void Function() changeColor);

Widget _defaultLayoutBuilder(
    BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;

  return SizedBox(
    width: 300.w,
    height: orientation == Orientation.portrait ? 300.h : 200.h,
    child: GridView.count(
      crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
      crossAxisSpacing: 5.w,
      mainAxisSpacing: 5.h,
      children: [for (Color color in colors) child(color)],
    ),
  );
}

Widget _defaultItemBuilder(
    Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(50),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 210),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            color: Colors.black,
            size: 33.sp,
          ),
        ),
      ),
    ),
  );
}

class CustomBlockPicker extends StatefulWidget {
  const CustomBlockPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = _defaultLayoutBuilder,
    this.itemBuilder = _defaultItemBuilder,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() => _BlockPickerState();
}

class _BlockPickerState extends State<CustomBlockPicker> {
  late Color _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(Color color) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (Color color, [bool? _, Function? __]) => widget.itemBuilder(
        color,
        (_currentColor.value == color.value) &&
            (widget.pickerColor.value == color.value),
        () => changeColor(color),
      ),
    );
  }
}

class CustomColorPicker extends StatefulWidget {
  final Color initalColor;
  final Function(Color) onColorSelected;
  const CustomColorPicker({
    required this.onColorSelected,
    this.initalColor = kPrimaryColor,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initalColor;
  }

  void onColorChanged(Color color) {
    setState(
      () {
        _selectedColor = color;
      },
    );
    widget.onColorSelected(color);
    Navigator.pop(context);
  }

  void onPressed() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AppTheme.dialogTheme(AlertDialog(
          title: const Text("Choose Color"),
          content: CustomBlockPicker(
            pickerColor: _selectedColor,
            onColorChanged: onColorChanged,
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TodoConfigItem(
      title: "Color",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 30.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.circular(6.sp),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.color_lens_outlined,
              color: _selectedColor,
            ),
          )
        ],
      ),
    );
  }
}
