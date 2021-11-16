import 'package:bigstars_mobile/helper/appConfig.dart';
import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(AppConfig(
      appName: "BigStars",
      flavorName: "dev",
      // initialRoute: ,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
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
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.SPLASH,
        title: 'BigStars App',
      ),
    );
  }

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Config.primary,
      ),
    );
  }
}
