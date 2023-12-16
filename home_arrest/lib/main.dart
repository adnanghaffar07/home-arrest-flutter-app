import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_arrest/providers/alerts_provider.dart';
import 'package:home_arrest/providers/auth_provider.dart';
import 'package:home_arrest/providers/dashboard_provider.dart';
import 'package:home_arrest/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'providers/client_provider.dart';
import 'providers/splash_provider.dart';
import 'routes.dart';
import 'theme/theme.dart';
import 'view/onboarding/splash/splash_screen.dart';
import 'data/helper/get_di.dart' as di;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(DevicePreview(
    enabled: kDebugMode,
    builder: (context) => const AppProvider(),
  ));
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientProvider(clientRepo: Get.find())),
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepo: Get.find())),
        ChangeNotifierProvider(create: (_) => SplashProvider(splashRepo: Get.find())),
        ChangeNotifierProvider(create: (_) => UserProvider(userRepo: Get.find())),
        ChangeNotifierProvider(create: (_) => ALertsProvider(alertsRepo: Get.find())),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
    ThemeData theme = getCustomThemeData(context, brightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(theme.appBarTheme.systemOverlayStyle ?? style);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      ),
    );
  }
}
