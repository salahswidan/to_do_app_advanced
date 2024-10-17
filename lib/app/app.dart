import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app_advanced/core/utils/app_colors.dart';
import 'package:to_do_app_advanced/core/utils/app_strings.dart';
import 'package:to_do_app_advanced/features/auth/data/presentation/cubit/task_cubit.dart';
import 'package:to_do_app_advanced/features/auth/data/presentation/cubit/task_state.dart';

import '../core/theme/theme.dart';
import '../features/auth/data/presentation/cubit/screens/splash_screen/splah_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return MaterialApp(
              theme: getAppTheme(),
              darkTheme: getAppDarkTheme(),
              themeMode: BlocProvider.of<TaskCubit>(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              title: AppStrings.appName,
              debugShowCheckedModeBanner: false,
              home: SplahScreen(),
            );
          },
        );
      },
    );
  }
}
