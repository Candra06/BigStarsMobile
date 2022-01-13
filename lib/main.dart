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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(AppConfig(
      appName: "BigStars",
      flavorName: "dev",
      initialRoute: Routes.SPLASH,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Config.primary,
      ),
    );
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
