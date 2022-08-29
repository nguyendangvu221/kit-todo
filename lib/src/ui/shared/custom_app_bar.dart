import 'package:flutter/material.dart';
import '../../utils/screen_utils/custom_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final Text? title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(67.h),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: AppBar(
          title: title,
          leadingWidth: 41.w,
          leading: leading,
          actions: actions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAppBar();
  }

  @override
  Size get preferredSize => Size.fromHeight(67.0.h);

  @override
  Widget get child => _buildAppBar();
}
