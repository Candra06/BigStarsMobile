import 'dart:convert';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/dashboardGuru_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/user_model.dart';
// import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
// import 'package:bigstars_mobile/page/admin/listItem/itemListKelasGuru.dart';
// import 'package:bigstars_mobile/page/admin/listItem/itemListKelasToday.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasTodayGuru.dart';
// import 'package:bigstars_mobile/page/guru/kelas/listItem.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeGuru extends StatefulWidget {
  const HomeGuru({Key key}) : super(key: key);

  @override
  _HomeGuruState createState() => _HomeGuruState();
}

class _HomeGuruState extends State<HomeGuru> {
  // Map<String, dynamic> dataUser = user.toJson();
  UserModel userModel;
  List<KelasModel> listKelasModel;
  Map<String, dynamic> user;
  DashboardGuruModel dashboardGuruModel;
  bool load = false;
  // var user;
  void getData() async {
    var userPref = await Pref.getUserModel();
    if (userPref != null) {
      user = json.decode(userPref);
    }
  }

  void initState() {
    super.initState();
    getData();
    dashboardGuruModel =
        Provider.of<AuthProvider>(context, listen: false).dashboardGuruModel;
    print(dashboardGuruModel.kelasAktif);
    listKelasModel =
        Provider.of<KelasProvider>(context, listen: false).allKelas;
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<AuthProvider>(context).user;
    // print(userModel.role);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Config.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.NOTIFIKASI);
                              },
                              child: Icon(
                                Icons.notifications,
                                color: Config.textWhite,
                                size: 30,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.PROFILE_GURU);
                              },
                              child: Icon(
                                Icons.person,
                                color: Config.textWhite,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Selamat Datang',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Config.textWhite),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          userModel.role,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Config.textWhite),
                        ),
                        Text(
                          userModel.username,
                          style:
                              TextStyle(fontSize: 18, color: Config.textWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Config.textWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.3,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                  color: Config.boxBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kelas Aktif',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Config.textWhite,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    dashboardGuruModel.kelasAktif.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Config.textWhite,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(
                                  color: Config.boxYellow,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fee Bulan Ini',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Config.textWhite,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    Config.formatRupiah(dashboardGuruModel.fee),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Config.textWhite,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Kelas Hari Ini'),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: dashboardGuruModel.kelasToday.length == 0
                              ? Center(child: Text('Tidak ada kelas hari ini'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      dashboardGuruModel.kelasToday.length,
                                  itemBuilder: (BuildContext cotext, int i) {
                                    print(dashboardGuruModel.kelasToday.length);

                                    if (dashboardGuruModel.kelasToday == []) {
                                      return Text('Belum ada data kelas');
                                    } else {
                                      return ItemKelasTodayGuru(
                                        data: dashboardGuruModel.kelasToday[i],
                                      );
                                    }
                                  }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Sharing Kelas Hari Ini'),
                        if (dashboardGuruModel.sharing.length > 0) ...{
                          SizedBox(
                            height: 10,
                          ),
                          // Jika data ada
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: dashboardGuruModel.sharing.length,
                              itemBuilder: (BuildContext cotext, int i) {
                                return ItemKelasTodayGuru(
                                  data: dashboardGuruModel.sharing[i],
                                );
                              },
                            ),
                          ),
                        } else ...{
                          //Jika data Kosong
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Tidak ada kelas yang dibagikan',
                              style: TextStyle(color: Config.textGrey),
                            ),
                          )
                        },
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
