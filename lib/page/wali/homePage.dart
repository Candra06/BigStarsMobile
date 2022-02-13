import 'dart:convert';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/dashboard_wali.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasGuru.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasWali.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasWaliToday.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWali extends StatefulWidget {
  const HomeWali({Key key}) : super(key: key);

  @override
  _HomeWaliState createState() => _HomeWaliState();
}

class _HomeWaliState extends State<HomeWali> {
  // Map<String, dynamic> dataUser = user.toJson();
  bool load = true;
  DashboardWaliModel dashboardWaliModel;
  UserModel userModel;
  Map<String, dynamic> user;
  String nama = '', username = '';
  // var user;
  void getData() async {
    var tmpNama = await Pref.getNama();
    var tmpUsername = await Pref.getUsername();
    setState(() {
      nama = tmpNama;
      username = tmpUsername;
      // load = true;
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // print(userModel.role);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Config.primary,
      body: FutureBuilder(
        future: Provider.of<AuthProvider>(context, listen: false).getDashboardWali(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Config.loader('Memuat data'),
            );
          }
          return Consumer<AuthProvider>(builder: (context, data, _) {
            return SingleChildScrollView(
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
                                Stack(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, Routes.NOTIFIKASI);
                                      },
                                      icon: Icon(
                                        Icons.notifications,
                                        color: Config.textWhite,
                                        size: 30,
                                      ),
                                    ),
                                    data.dashboardWaliModel.data.notifUnread != 0
                                        ? Positioned(
                                            right: 13,
                                            top: 11,
                                            child: new Container(
                                              padding: EdgeInsets.all(0),
                                              decoration: new BoxDecoration(
                                                color: Config.boxBlue,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 10,
                                                minHeight: 10,
                                              ),
                                              child: Text(
                                                ' ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : new Container()
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.PROFILE_WALI);
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
                              nama,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Config.textWhite),
                            ),
                            Text(
                              username,
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
                                  decoration: BoxDecoration(color: Config.boxBlue, borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Kehadiran',
                                        style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 18),
                                      ),
                                      Text(
                                        data.dashboardWaliModel.data.kehadiran,
                                        style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 20),
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
                                        'SPP Bulan Ini',
                                        style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 18),
                                      ),
                                      Text(
                                        Config.formatRupiah(data.dashboardWaliModel.data.spp),
                                        style: TextStyle(fontWeight: FontWeight.w800, color: Config.textWhite, fontSize: 20),
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
                              child: data.dashboardWaliModel.data.kelasToday.length == 0
                                  ? Center(child: Text('Tidak ada kelas hari ini'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: data.dashboardWaliModel.data.kelasToday.length,
                                      itemBuilder: (BuildContext cotext, int i) {
                                        print(data.dashboardWaliModel.data.kelasToday.length);
                                        // var data = {"id_kelas": 1, "siswa": "Kekeyi", "mapel": "Calistung", "spp": 32000, "jam_mulai": "15.00", "jam_selesai": "16.00", "guru": "Mr. Revo"};
                                        if (data.dashboardWaliModel.data.kelasToday == []) {
                                          return Text('Belum ada data kelas');
                                        } else {
                                          return ItemKelasTodayWali(
                                            data: data.dashboardWaliModel.data.kelasToday[i],
                                          );
                                        }
                                      }),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        },
      ),
    ));
  }
}
