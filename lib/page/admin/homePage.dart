import 'dart:convert';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/dashboard_model.dart';

import 'package:bigstars_mobile/model/kelasToday_model.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasToday.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  // Map<String, dynamic> dataUser = user.toJson();
  UserModel userModel;

  Map<String, dynamic> user;
  DashboardModel dashboardModel;

  void getData() {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    dashboardModel = authProvider.dashboardModel;
    userModel = authProvider.user;
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            Icon(
                              Icons.notifications,
                              color: Config.textWhite,
                              size: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.PROFILE_ADMIN);
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Config.textWhite),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          userModel.role,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Config.textWhite),
                        ),
                        Text(
                          userModel.username,
                          style: TextStyle(fontSize: 18, color: Config.textWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Config.textWhite, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(color: Config.boxGreen, borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Siswa',
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 18),
                                  ),
                                  Text(
                                    dashboardModel.siswa.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 24),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(color: Config.boxRed, borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kelas',
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 18),
                                  ),
                                  Text(
                                    dashboardModel.kelas.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 24),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(color: Config.boxBlue, borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Guru',
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 18),
                                  ),
                                  Text(
                                    dashboardModel.guru.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 24),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(color: Config.boxYellow, borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kelas Aktif',
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 18),
                                  ),
                                  Text(
                                    dashboardModel.kelasAktif.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 24),
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
                        GridView.count(
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.LIST_MAPEL);
                              },
                              child: Container(
                                  height: 90,
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/icons/iconMapel.png'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Mapel')
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.LIST_SPP);
                              },
                              child: Container(
                                  height: 90,
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/icons/iconSPP.png'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('SPP Murid')
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.LIST_FEE);
                              },
                              child: Container(
                                  height: 90,
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/icons/iconFee.png'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Fee Guru')
                                    ],
                                  )),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Text('Kelas Hari Ini'),
                        SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   child: ListView(
                        //     children: [
                        //       for (var i = 0; i < todayKelas.length; i++) ...{
                        //         ItemKelasToday(data: todayKelas[i]),
                        //       }
                        //     ],
                        //   ),
                        // ),
                        if (dashboardModel.kelasToday.length == 0) ...{
                          Center(
                            child: Text('Tidak ada kelas hari ini'),
                          )
                        } else ...{
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: dashboardModel.kelasToday.length,
                                itemBuilder: (BuildContext cotext, int i) {
                                  if (dashboardModel.kelasToday.isEmpty) {
                                    return Center(
                                      child: Text('Tidak ada kelas hari ini'),
                                    );
                                  } else {
                                    print(dashboardModel.kelasToday[i]);
                                    return ItemKelasToday(
                                      data: dashboardModel.kelasToday[i],
                                    );
                                  }
                                }),
                          )
                        }
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
