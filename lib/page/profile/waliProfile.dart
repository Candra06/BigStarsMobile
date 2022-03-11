import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemSiswaByWali.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:bigstars_mobile/page/modal/changePhotoProfile.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilWali extends StatefulWidget {
  const ProfilWali({Key key}) : super(key: key);

  @override
  _ProfilWaliState createState() => _ProfilWaliState();
}

class _ProfilWaliState extends State<ProfilWali> {
  String nama = '', username = '', phone = '', foto = '';

  void unauthenticated() async {
    var status = await Provider.of<AuthProvider>(context, listen: false).logout();
    print(status);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getKeys();
    for (String key in pref.getKeys()) {
      if (key != "setuju") {
        pref.remove(key);
      }
    }
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: LoginPage(),
        type: PageTransitionType.topToBottom,
      ),
    );
  }

  void _logOut() async {
    return await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Apakah anda yakin?'),
        content: new Text('Ingin keluar dari akun ini.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Tidak'),
          ),
          new FlatButton(
            onPressed: () {
              unauthenticated();
              // Navigator.pushReplacement(context, PageTransition(child: LoginPage(), type: PageTransitionType.topToBottom));
            },
            child: new Text('Iya'),
          ),
        ],
      ),
    );
  }

  void getData() async {
    var tmpNama = await Pref.getNama();
    var tmpFoto = await Pref.getFoto();
    var tmpUsername = await Pref.getUsername();
    var tmpPhone = await Pref.getPhone();
    setState(() {
      nama = tmpNama;
      foto = tmpFoto;
      phone = tmpPhone;
      username = tmpUsername;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Config.textWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                    gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Config.primary, Config.secondary])),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.HOME_WALI, arguments: '0');
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Config.textWhite,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _logOut();
                          },
                          child: Icon(
                            Icons.logout,
                            color: Config.textWhite,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipOval(
                      child: Image.network(
                        foto == '-' || foto == '' ? "https://www.clipartmax.com/png/middle/257-2572603_user-man-social-avatar-profile-icon-man-avatar-in-circle.png" : EndPoint.server + foto,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      nama,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Config.textWhite, fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      username,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Config.textWhite, fontSize: 18),
                    ),
                    Text(
                      phone,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Config.textWhite, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ModalChangePhotoProfile();
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1, color: Config.primary),
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: Config.textWhite,
                    onPrimary: Config.textWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Config.primary,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Edit Foto",
                        style: TextStyle(color: Config.primary, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.EDIT_PROFILE_WALI);
                  },
                  style: ElevatedButton.styleFrom(
                    // side: BorderSide(width: 1, color: Config.primary),
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: Config.primary,
                    onPrimary: Config.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Config.textWhite,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Edit Akun",
                        style: TextStyle(color: Config.textWhite, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('Data Siswa'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: FutureBuilder(
                  future: Provider.of<SiswaProvider>(context, listen: false).getSiswaByWali(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Consumer<SiswaProvider>(
                      builder: (context, data, _) {
                        return ListView.builder(
                          itemCount: data.listSiswa.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int i) {
                            return ItemListSiswaByWali(
                              data: data.listSiswa[i],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
