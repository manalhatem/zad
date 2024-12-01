import 'package:alarm/alarm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zad/screens/my_app.dart';
import 'core/utils/set_theme.dart';

/// easy localization
/// dart run easy_localization:generate -S assets/translations
/// dart run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations
/// flutter packages pub run build_runner build

final navigatorKey = GlobalKey<NavigatorState>();
// final  showCaseWidgetKey = GlobalKey<ShowCaseWidgetState>();

final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Alarm.init();
  await Hive.initFlutter();
  await Future.wait([Firebase.initializeApp(),CacheHelper.initCache()]);
  setThemeMode();
  runApp(EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [Locale('en'), Locale('ar')],
      startLocale: const Locale('ar'),
      path: 'assets/translations',
      child: const MyApp()));

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((event) {
    if (event.notification != null) {
    }
  });
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
}
