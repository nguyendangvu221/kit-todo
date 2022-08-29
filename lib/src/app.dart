import 'package:flutter/material.dart';
import 'utils/screen_utils/custom_screenutil.dart';
import 'package:todo_app/src/ui/providers/providers.dart';
import 'package:todo_app/src/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import './ui/screens/screens.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390.0, 844.0),
      builder: () {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => TodoManager())
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
