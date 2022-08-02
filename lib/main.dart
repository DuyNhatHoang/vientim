import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';
import 'package:vkhealth/app/providers/firebase_provider.dart';
import 'package:vkhealth/app/providers/setting_providers.dart';
import 'package:vkhealth/app/services/auth_service.dart';
import 'package:vkhealth/app/services/firebase_massage_service.dart';
import 'package:vkhealth/app/services/global_service.dart';
import 'package:vkhealth/app/services/setting_service.dart';
import 'package:vkhealth/app/services/translation_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/routes/theme1_app_page.dart';

Future<void> initServices() async{
  Get.log('starting service ...');
  await GetStorage.init();
  await Firebase.initializeApp(); 
  await Get.putAsync(() => TranslationService().init());
  await Get.putAsync(() => GlobalServices().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => SettingProvider().init());
  await Get.putAsync(() => FirebaseProvider().init());
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => DotnetProvider().init());
  Get.log('all service started ...');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //// This line is used for showing the bottom bar
    SystemUiOverlay.top, //// This line is used for showing the bottom bar
  ]);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.red,
  //   systemNavigationBarIconBrightness: Brightness.dark,
  // ));
  SystemChrome.restoreSystemUIOverlays();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
      runApp(
        GetMaterialApp(
          title: "Duy",
          initialRoute: Theme1AppPages.INITIAL,
          onReady: () async {
            await Get.putAsync(() => FireBaseMessageService().init());
          },
          getPages: Theme1AppPages.routes,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: Get.find<TranslationService>().supportedLocales(),
          translationsKeys: Get.find<TranslationService>().translations,
          locale: Get.find<SettingsService>().getLocale(),
          fallbackLocale: Get.find<TranslationService>().fallbackLocale,
          debugShowCheckedModeBanner: false,
          color: Colors.black,
          defaultTransition: Transition.cupertino,
          themeMode: Get.find<SettingsService>().getThemeMode(),
          theme: Get.find<SettingsService>().getLightTheme(),
          darkTheme: Get.find<SettingsService>().getDarkTheme(),

        ),
      );
  });
}
