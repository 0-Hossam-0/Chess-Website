import 'package:chess_app/core/theme/app_theme.dart';
import 'package:chess_app/features/authentication/screen/auth_screen.dart';
import 'package:chess_app/core/navigation/widget/navigation_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Midnight Chess',
          theme: AppTheme.darkTheme,
          home: const NavigationRoot(),
        );
      },
    );
  }
}
