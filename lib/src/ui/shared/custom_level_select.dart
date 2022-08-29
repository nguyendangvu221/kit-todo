import 'package:flutter/material.dart';
import '../../resources/data/models.dart';
import 'todo_config_item.dart';

class CustomLevelSelect extends StatelessWidget {
  final Level initialLevel;
  final void Function(Level) onLevelSelected;

  const CustomLevelSelect({
    Key? key,
    required this.initialLevel,
    required this.onLevelSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoConfigItem(
      title: "Level",
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: Level.values
            .map(
              (e) => ChoiceChip(
                selected: initialLevel == e,
                label: Text(e.toString().split(".").last),
                onSelected: (_) {
                  onLevelSelected(e);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
