import 'package:bigstars_mobile/page/admin/mapel/addMapel.dart';
import 'package:bigstars_mobile/page/admin/mapel/listMapel.dart';
import 'package:bigstars_mobile/page/admin/pengguna/guru/addGuru.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:bigstars_mobile/page/auth/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:sociable/MainPage.dart';

// import 'package:sociable/Pages/Auth/Login/loginPage.dart';
// import 'package:sociable/Pages/Auth/Registrasi/registrationPage.dart';
// import 'package:sociable/Pages/Challenges/detail_challenges/detailChallanges.dart';
// import 'package:sociable/Pages/Challenges/widget/challenges_item.dart';
// import 'package:sociable/Pages/Forum/add_new_forum/add_new_forum.dart';
// import 'package:sociable/Pages/Konsultasi/view/listRoom.dart';
// import 'package:sociable/Pages/Konsultasi/view/roomChat.dart';
// import 'package:sociable/Pages/Membership/membership.dart';
// import 'package:sociable/Pages/splash.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String LIST_MAPEL = '/list_mapel';
  static const String ADD_MAPEL = '/add_mapel';
  static const String ADD_GURU = '/add_guru';
  static const String HOME = '/home';
  static const String AKUN = '/akun';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return PageTransition(
            child: LoginPage(), type: PageTransitionType.leftToRight);
      case LIST_MAPEL:
        return PageTransition(
            child: ListMapel(), type: PageTransitionType.leftToRight);
      case ADD_MAPEL:

        Map<String, dynamic> data = settings.arguments;
        return PageTransition(
            child: AddMapel(
              id: data["id"],
              mapel: data["mapel"],
            ),
            type: PageTransitionType.bottomToTop);


      // case AKUN:
      //   var data = settings.arguments;
      //   return PageTransition(
      //       child: AkunPage(
      //         idUser: 1,
      //         namaUser: '',
      //       ),
      //       type: PageTransitionType.leftToRight);
      // case TAB:
      //   return PageTransition(
      //       child: Tabs(
      //         indexPage: settings.arguments,
      //       ),
      //       type: PageTransitionType.leftToRight);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Page ${settings.name} not defined'),
                  ),
                ));
    }
  }
}
