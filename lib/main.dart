import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testappifylab/routes/app_pages.dart';
import 'package:testappifylab/routes/app_routes.dart';
import 'package:testappifylab/utils/text_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'binding/view_model_binding.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          translations: TextConst(),
          locale: const Locale('en', 'UK'),
          initialBinding: ViewModelBinding(),
          title: 'Britbite',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),
          initialRoute: AppRoutes.LoginScreen,
          getPages: AppPages.list,
        );
      },
    );
  }
}
