import 'package:flutter/material.dart';
import 'package:todo_app/src/utils/screen_utils/custom_screenutil.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/empty.png",
          width: 200.w,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "It seems we have nothing here",
          style: TextStyle(fontSize: 14.sp),
        )
      ],
    );
  }
}
