import 'package:bigstars_mobile/page/admin/absensi/listAbsensi.dart';
import 'package:bigstars_mobile/page/admin/absensi/listGuru.dart';
import 'package:bigstars_mobile/page/admin/finance/listFeeGuru.dart';
import 'package:bigstars_mobile/page/admin/finance/listSppMurid.dart';
import 'package:bigstars_mobile/page/admin/finance/detailInvoiceFee.dart';
import 'package:bigstars_mobile/page/admin/finance/detailInvoiceSpp.dart';
import 'package:bigstars_mobile/page/admin/finance/listFeeGuru.dart';
import 'package:bigstars_mobile/page/admin/finance/listSppMurid.dart';
import 'package:bigstars_mobile/page/admin/finance/reportPage.dart';
import 'package:bigstars_mobile/page/admin/kelas/addKelas.dart';
import 'package:bigstars_mobile/page/admin/kelas/detailKelas.dart';
import 'package:bigstars_mobile/page/admin/mainPage.dart';
import 'package:bigstars_mobile/page/admin/mapel/addMapel.dart';
import 'package:bigstars_mobile/page/admin/listItem/listMapel.dart';
import 'package:bigstars_mobile/page/admin/pengguna/guru/addGuru.dart';
import 'package:bigstars_mobile/page/admin/pengguna/guru/detailGuru.dart';
import 'package:bigstars_mobile/page/admin/pengguna/siswa/addSiswa.dart';
import 'package:bigstars_mobile/page/admin/pengguna/siswa/detailSiswa.dart';
import 'package:bigstars_mobile/page/admin/pengguna/siswa/editSiswa.dart';
import 'package:bigstars_mobile/page/admin/pengguna/wali/detailWali.dart';
import 'package:bigstars_mobile/page/admin/pengguna/wali/editWali.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:bigstars_mobile/page/auth/splash.dart';
import 'package:bigstars_mobile/page/guru/kelas/detailKelas.dart';
import 'package:bigstars_mobile/page/guru/mainPage.dart';
import 'package:bigstars_mobile/page/notifikasi/notifikasi.dart';
import 'package:bigstars_mobile/page/profile/adminProfile.dart';
import 'package:bigstars_mobile/page/profile/editAkunAdmin.dart';
import 'package:bigstars_mobile/page/profile/editAkunGuru.dart';
import 'package:bigstars_mobile/page/profile/editAkunWali.dart';
import 'package:bigstars_mobile/page/profile/guruProfile.dart';
import 'package:bigstars_mobile/page/profile/waliProfile.dart';
import 'package:bigstars_mobile/page/wali/kelas/detailKelas.dart';
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
  static const String ADD_KELAS = '/add_kelas';
  static const String DETAIL_KELAS = '/detail_kelas';
  static const String DETAIL_SPP = '/detail_spp';
  static const String DETAIL_FEE = '/detail_fee';
  static const String FINANCE = '/detail_fee';
  static const String REPORT = '/report';
  static const String NOTIFIKASI = '/notifikasi';
  static const String DATA_GURU_ABSENSI = '/absensi_guru';
  static const String DATA_GURU_ABSENSI_DETAIL = '/absensi_guru_detail';

  //Guru
  static const String HOME_GURU = '/home_guru';
  static const String PROFILE_GURU = '/profile_guru';
  static const String EDIT_PROFILE_GURU = '/edit_profile_guru';
  static const String DETAIL_KELAS_GURU = '/detail_kelas_guru';

  //Wali
  static const String HOME_WALI = '/home_wali';
  static const String PROFILE_WALI = '/profile_wali';
  static const String EDIT_PROFILE_WALI = '/edit_profile_wali';
  static const String DETAIL_KELAS_WALI = '/detail_kelas_wali';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HOME_ADMIN:
        return PageTransition(
            child: AdminMain(
              indexPage: settings.arguments,
            ),
            type: PageTransitionType.leftToRight);
      case HOME_GURU:
        return PageTransition(
            child: GuruMain(
              indexPage: settings.arguments,
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
        Map<String, dynamic> data = settings.arguments;
        return PageTransition(
            child: AddGuru(
              id: data["id"],
              guru: data["guru"],
            ),
            type: PageTransitionType.bottomToTop);
      case ADD_SISWA:
        return PageTransition(child: AddSiswa(id: settings.arguments), type: PageTransitionType.bottomToTop);

      case DETAIL_SISWA:
        return PageTransition(child: DetailSiswa(siswa: settings.arguments), type: PageTransitionType.bottomToTop);
      case DETAIL_WALI:
        return PageTransition(child: DetailWaliSiswa(wali: settings.arguments), type: PageTransitionType.bottomToTop);
      case DETAIL_GURU:
        return PageTransition(child: DetailGuru(guru: settings.arguments), type: PageTransitionType.bottomToTop);

      case EDIT_SISWA:
        return PageTransition(child: EditSiswa(siswa: settings.arguments), type: PageTransitionType.bottomToTop);
      case EDIT_WALI:
        return PageTransition(child: EditWali(wali: settings.arguments), type: PageTransitionType.bottomToTop);
      case PROFILE_ADMIN:
        return PageTransition(child: ProfilAdmin(), type: PageTransitionType.bottomToTop);
      case EDIT_PROFILE_ADMIN:
        return PageTransition(child: EditAkunAdmin(), type: PageTransitionType.bottomToTop);
      case LIST_SPP:
        return PageTransition(child: ListSppMurid(), type: PageTransitionType.bottomToTop);
      case LIST_FEE:
        return PageTransition(child: ListFeeGuru(), type: PageTransitionType.bottomToTop);
      case ADD_KELAS:
        return PageTransition(child: AddKelasAdmin(), type: PageTransitionType.leftToRight);
      case DETAIL_KELAS:
        return PageTransition(child: DetailKelas(kelas: settings.arguments), type: PageTransitionType.bottomToTop);
      case PROFILE_ADMIN:
        return PageTransition(child: ProfilAdmin(), type: PageTransitionType.bottomToTop);
      case EDIT_PROFILE_ADMIN:
        return PageTransition(child: EditAkunAdmin(), type: PageTransitionType.bottomToTop);
      case LIST_SPP:
        return PageTransition(child: ListSppMurid(), type: PageTransitionType.bottomToTop);
      case LIST_FEE:
        return PageTransition(child: ListFeeGuru(), type: PageTransitionType.bottomToTop);
      case DATA_GURU_ABSENSI:
        return PageTransition(child: ListGuruAbsensi(), type: PageTransitionType.bottomToTop);
      case DATA_GURU_ABSENSI_DETAIL:
        return PageTransition(
            child: ListAbsensi(
              id: settings.arguments,
            ),
            type: PageTransitionType.bottomToTop);
      case DETAIL_SPP:
        return PageTransition(
            child: InvoiceSPP(
              id: settings.arguments,
            ),
            type: PageTransitionType.leftToRight);
      case DETAIL_FEE:
        return PageTransition(
            child: InvoiceFee(
              fee: settings.arguments,
            ),
            type: PageTransitionType.leftToRight);
      case PROFILE_GURU:
        return PageTransition(child: ProfilGuru(), type: PageTransitionType.leftToRight);
      case EDIT_PROFILE_GURU:
        return PageTransition(child: EditAkunGuru(), type: PageTransitionType.leftToRight);
      case DETAIL_KELAS_GURU:
        return PageTransition(
            child: DetailKelasGuru(
              kelas: settings.arguments,
            ),
            type: PageTransitionType.leftToRight);
      case DETAIL_KELAS_WALI:
        return PageTransition(
            child: DetailKelasWali(
              id: settings.arguments,
            ),
            type: PageTransitionType.leftToRight);
      case PROFILE_WALI:
        return PageTransition(child: ProfilWali(), type: PageTransitionType.leftToRight);
      case EDIT_PROFILE_WALI:
        return PageTransition(child: EditAkunWali(), type: PageTransitionType.leftToRight);
      case NOTIFIKASI:
        return PageTransition(child: NotificationPage(), type: PageTransitionType.bottomToTop);
      case REPORT:
        return PageTransition(child: ReportPage(), type: PageTransitionType.bottomToTop);
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
