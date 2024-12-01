import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/utils/azan_cubit.dart';
import 'package:zad/core/utils/theme.dart';
import 'package:zad/core/widgets/locale_db.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/main.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/splash/view/splash_view.dart';
import '../core/local/app_cached.dart';
import 'alward_alsarie/controller/alward_alsarie_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///================================ request permission =========================//
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==AuthorizationStatus.provisional) {
    } else {
    }
  }
  ///================================ request permission =========================//
  ///================================ show local notification =========================//
  void initializeLocalNotification() {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                playSound: true,
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }
  ///================================ show local notification =========================//
  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    initializeLocalNotification();
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(statusBarColor: Colors.transparent,
        statusBarIconBrightness: CacheHelper.getData(key: AppCached.theme) ==
            AppCached.darkTheme? Brightness.light:Brightness.dark));
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleDbCubit()..initLocale(),lazy: false,),
        BlocProvider(create: (context) => SoraDetailsCubit()),
        BlocProvider(create: (context) => AzanCubit()),
        BlocProvider(create: (context) => AlwardAlsarieCubit()..fetchTracks(),)
      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          ensureScreenSize: true,
          builder: (_, child) {
            return AdaptiveTheme(
                light: AppTheme.lightTheme,
                dark: AppTheme.darkTheme,
                initial: CacheHelper.getData(key: AppCached.theme) ==
                    AppCached.darkTheme ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light,
                builder: (ThemeData light, ThemeData dark) =>MaterialApp(
                    navigatorKey: navigatorKey,
                    title: LocaleKeys.appName.tr(),
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    theme: light,
                    darkTheme: dark,
                    home:   const SplashScreen()));
          }),
    );
  }
}