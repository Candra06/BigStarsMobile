import 'dart:convert';
import 'dart:io';
import 'package:bigstars_mobile/helper/appConfig.dart';
import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:bigstars_mobile/provider/wali_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(
    AppConfig(
      appName: "BigStars",
      flavorName: "dev",
      initialRoute: Routes.SPLASH,
      child: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Config.primary,
      ),
    );
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final firebaseMessaging = FirebaseMessaging();
  final controllerTopic = TextEditingController();
  bool isSubscribed = false;
  String token = '';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // ketika notifikasi di klik
  Future onSelectNotification(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('onNotification', message);
  }

  @override
  void initState() {
    super.initState();

    try {
      //setting local notification init
      flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
      var iOS = new IOSInitializationSettings();
      var initSetttings = new InitializationSettings(android: android, iOS: iOS);

      flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);
      // setting local notification init
      // configurasi fcm
      // firebaseMessaging.configure(
      //   onMessage: (Map<String, dynamic> message) async {
      //     print("onMessage: $message");
      //     _showNotificationWithDefaultSound(message, "onMessage");
      //   },
      //   onLaunch: (Map<String, dynamic> message) async {
      //     print("onLaunch: $message");
      //     _showNotificationWithDefaultSound(message, "onLaunch"); 
      //   },
      //   onResume: (Map<String, dynamic> message) async {
      //     print("onResume: $message");
      //     _showNotificationWithDefaultSound(message, "onResume");
      //   },
      // );
      // firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
      // firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      //   print("Settings registered: $settings");
      // });
      // firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      //   debugPrint('Settings registered: $settings');
      // });
      // firebaseMessaging.getToken().then((String token) async {
      //   assert(token != null);
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.setString('fcm_token', token.toString());
      //   print('fcm : ' + token);
      // });
    } catch (e) {
      print(e);
    }
  }

  //menampilkan baloon notifikasi dari flutter_locacl_notification
  Future _showNotificationWithDefaultSound(Map<String, dynamic> message, var tipe) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      '329382938298',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    // // key dan nilai untuk action click
    String kontenpay = json.encode(message).toString();
    if (tipe == "onResume") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('onNotification', kontenpay);
    } else {
      await flutterLocalNotificationsPlugin.show(
        0,
        message["notification"]["title"],
        message["notification"]["body"],
        platformChannelSpecifics,
        payload: kontenpay,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var initialRoute = AppConfig.of(context).initialRoute;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(),
        ),
        ChangeNotifierProvider<MapelProvider>(
          create: (context) => MapelProvider(),
        ),
        ChangeNotifierProvider<GuruProvider>(
          create: (context) => GuruProvider(),
        ),
        ChangeNotifierProvider<WaliProvider>(
          create: (context) => WaliProvider(),
        ),
        ChangeNotifierProvider<SiswaProvider>(
          create: (context) => SiswaProvider(),
        ),
        ChangeNotifierProvider<FinanceProvider>(
          create: (contex) => FinanceProvider(),
        ),
        ChangeNotifierProvider<KelasProvider>(
          create: (contex) => KelasProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        initialRoute: initialRoute,
        title: 'BigStars App',
      ),
    );
  }
}
