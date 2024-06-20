import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Pallete.borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Pallete.gradient2,
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    )
  );
}