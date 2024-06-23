import 'package:cf_sarasavi_app/utils/constants/colors.dart';
import 'package:cf_sarasavi_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/general_bindings.dart';

/// -- Use this Class to setup themes, initial Bindings, any animations and much more using Material Widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),

      /// Show Loader or Circular Progress Indicator Meanwhile Authentication Repository is Deciding to Show Relevent Screen.
      home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}