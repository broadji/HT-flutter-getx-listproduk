import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ht_flutter_getx_listproduk/core/config/theme/app_theme.dart';
import 'package:ht_flutter_getx_listproduk/core/config/translations/localization_service.dart';
import 'package:ht_flutter_getx_listproduk/core/routes/app_pages.dart';
import 'package:ht_flutter_getx_listproduk/data/local/prefs.dart';

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();

  // init shared preference
  await Prefs.init();

  runApp(
    ScreenUtilInit(
      // todo add your (Xd / Figma) artboard size
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          // todo add your app name
          title: "GetXSkeleton",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: (context,widget) {
            bool themeIsLight = Prefs.getThemeIsLight();
            return Theme(
              data: AppTheme.getThemeData(isLight: themeIsLight),
              child: MediaQuery(
                // prevent font from scalling (some people use big/small device fonts)
                // but we want our app font to still the same and dont get affected
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ),
            );
          },
          initialRoute: AppPages.INITIAL, // first screen to show when app is running
          getPages: AppPages.routes, // app screens
          locale: Prefs.getCurrentLocal(), // app language
          translations: LocalizationService(), // localization services in app (controller app language)
        );
      },
    ),
  );
}
