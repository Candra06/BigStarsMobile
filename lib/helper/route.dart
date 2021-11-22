import 'package:bigstars_mobile/page/admin/finance/listFeeGuru.dart';
import 'package:bigstars_mobile/page/admin/finance/listSppMurid.dart';
import 'package:bigstars_mobile/page/admin/mainPage.dart';
import 'package:bigstars_mobile/page/admin/mapel/addMapel.dart';
import 'package:bigstars_mobile/page/admin/mapel/listMapel.dart';
import 'package:bigstars_mobile/page/admin/pengguna/guru/addGuru.dart';
import 'package:bigstars_mobile/page/admin/pengguna/guru/detailGuru.dart';
import 'package:bigstars_mobile/page/admin/pengguna/siswa/addSiswa.dart';
import 'package:bigstars_mobile/page/admin/pengguna/siswa/detailSiswa.dart';
import 'package:bigstars_mobile/page/admin/pengguna/siswa/editSiswa.dart';
import 'package:bigstars_mobile/page/admin/pengguna/wali/detailWali.dart';
import 'package:bigstars_mobile/page/admin/pengguna/wali/editWali.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:bigstars_mobile/page/auth/splash.dart';
import 'package:bigstars_mobile/page/profile/adminProfile.dart';
import 'package:bigstars_mobile/page/profile/editAkunAdmin.dart';
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
  static const String HOME_ADMIN = '/home_admin';
  static const String LIST_MAPEL = '/list_mapel';
  static const String ADD_MAPEL = '/add_mapel';
  static const String ADD_GURU = '/add_guru';
  static const String ADD_SISWA = '/add_siswa';
  static const String DETAIL_GURU = '/detail_guru';
  static const String DETAIL_SISWA = '/detail_siswa';
  static const String EDIT_SISWA = '/edit_siswa';
  static const String EDIT_WALI = '/edit_wali';
  static const String DETAIL_WALI = '/detail_wali';
  static const String HOME = '/home';
  static const String PROFILE_ADMIN = '/profile_admin';
  static const String EDIT_PROFILE_ADMIN = '/edit_profile_admin';
  static const String LIST_SPP = '/list_spp';
  static const String LIST_FEE = '/list_fee';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HOME_ADMIN:
        return PageTransition(
            child: AdminMain(
              indexPage: '0',
            ),
            type: PageTransitionType.leftToRight);
      case LOGIN:
        return PageTransition(child: LoginPage(), type: PageTransitionType.leftToRight);
      case LIST_MAPEL:
        return PageTransition(child: ListMapel(), type: PageTransitionType.leftToRight);
      case ADD_MAPEL:
        Map<String, dynamic> data = settings.arguments;
        return PageTransition(
            child: AddMapel(
              id: data["id"],
              mapel: data["mapel"],
            ),
            type: PageTransitionType.bottomToTop);
      case ADD_GURU:
        return PageTransition(
            child: AddGuru(id: settings.arguments),
            type: PageTransitionType.bottomToTop);
      case ADD_SISWA:
        return PageTransition(
            child: AddSiswa(id: settings.arguments),
            type: PageTransitionType.bottomToTop);
      case DETAIL_SISWA:
        return PageTransition(
            child: DetailSiswa(id: settings.arguments),
            type: PageTransitionType.bottomToTop);
      case DETAIL_WALI:
        return PageTransition(
            child: DetailWaliSiswa(id: settings.arguments),
            type: PageTransitionType.bottomToTop);
      case DETAIL_GURU:
        return PageTransition(
            child: DetailGuru(id: settings.arguments),
            type: PageTransitionType.bottomToTop);
      case EDIT_SISWA:
        return PageTransition(
            child: EditSiswa(id: settings.arguments),
            type: PageTransitionType.bottomToTop);
      case EDIT_WALI:
<<<<<<< HEAD
        return PageTransition(
            child: EditWali(id: settings.arguments),
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
=======
        return PageTransition(child: EditWali(id: settings.arguments), type: PageTransitionType.bottomToTop);
      case PROFILE_ADMIN:
        return PageTransition(child: ProfilAdmin(), type: PageTransitionType.bottomToTop);
      case EDIT_PROFILE_ADMIN:
        return PageTransition(child: EditAkunAdmin(), type: PageTransitionType.bottomToTop);
      case LIST_SPP:
        return PageTransition(child: ListSppMurid(), type: PageTransitionType.bottomToTop);
      case LIST_FEE:
        return PageTransition(child: ListFeeGuru(), type: PageTransitionType.bottomToTop);

>>>>>>> 1dd02d187595fc8acad042d6f642f9185fdcaa6c
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
