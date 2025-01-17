import 'dart:io';

import 'package:cetici_driver/common/color_extension.dart';
import 'package:cetici_driver/common/db_helper.dart';
import 'package:cetici_driver/common/globs.dart';
import 'package:cetici_driver/common/my_http_overrides.dart';
import 'package:cetici_driver/common/service_call.dart';
import 'package:cetici_driver/common/socket_manager.dart';
import 'package:cetici_driver/cubit/login_cubit.dart';
import 'package:cetici_driver/view/login/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

SharedPreferences? prefs;

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  DBHelper.shared().db;

  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCIpuLRzkjkPzlcyQ3hzEolhgJ0mqlh3lw",
          projectId: "taxi-driver-7de52",
          messagingSenderId: "143832489419",
          appId: "1:143832489419:android:620ed1f46ef959efce6a4e"));

  if (Globs.udValueBool(Globs.userLogin)) {
    ServiceCall.userObj = Globs.udValue(Globs.userPayload) as Map? ?? {};
    ServiceCall.userType = ServiceCall.userObj["user_type"] as int? ?? 1;
  }
  SocketManager.shared.initSocket();

  runApp(const MyApp());
  configLoading();
  ServiceCall.getStaticDateApi();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = TColor.primaryText
    ..backgroundColor = TColor.primary
    ..indicatorColor = Colors.white
    ..textColor = TColor.primaryText
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginCubit())],
      child: MaterialApp(
        title: 'Taxi Driver',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "NunitoSans",
          scaffoldBackgroundColor: TColor.bg,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
          useMaterial3: false,
        ),
        home: const SplashView(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
