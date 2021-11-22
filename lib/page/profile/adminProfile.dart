import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/modal/changePhotoProfile.dart';
import 'package:flutter/material.dart';

class ProfilAdmin extends StatefulWidget {
  const ProfilAdmin({Key key}) : super(key: key);

  @override
  _ProfilAdminState createState() => _ProfilAdminState();
}

class _ProfilAdminState extends State<ProfilAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Config.textWhite,
          child: Column(
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
                            Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '0');
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Config.textWhite,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.HOME, arguments: '0');
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
                      height: 35,
                    ),
                    ClipOval(
                      child: Image.network(
                        "https://www.clipartmax.com/png/middle/257-2572603_user-man-social-avatar-profile-icon-man-avatar-in-circle.png",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Admin',
                      style: TextStyle(color: Config.textWhite, fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'admin@bigstars.com',
                      style: TextStyle(color: Config.textWhite, fontSize: 18),
                    ),
                    Text(
                      '087757630094',
                      style: TextStyle(color: Config.textWhite, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                    Navigator.pushNamed(context, Routes.EDIT_PROFILE_ADMIN);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
