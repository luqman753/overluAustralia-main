import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovulu/app.dart';
import 'package:ovulu/translations/codegen_loader.g.dart';
import 'package:ovulu/views/SplashView/splash_view.dart';

void main() async {
  setupGetx();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Ovulu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Glacial Indifference',
      ),
      home: SplashView(),
    );
  }
}
