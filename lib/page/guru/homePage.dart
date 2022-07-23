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
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String name = '', username = '';
  int notifUnread = 0;
  // var user;
  void getData() async {
    setState(() {
      load = true;
    });
    var tmpName = await Pref.getNama();
    var tmpUsername = await Pref.getUsername();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    dashboardGuruModel = await authProvider.getDashboardGuru();
    if (mounted) {
      setState(() {
        notifUnread = dashboardGuruModel.notifUnread ?? 0;
        name = tmpName;
        username = tmpUsername;
        load = false;
      });
    }
  }

  void initState() {
    super.initState();
    getData();
    // dashboardGuruModel = Provider.of<AuthProvider>(context, listen: false).dashboardGuruModel;

    // listKelasModel = Provider.of<KelasProvider>(context, listen: false).allKelas;
  }

  @override
  void dispose() {
    super.dispose();
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
                            Stack(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.NOTIFIKASI);
                                  },
                                  icon: Icon(
                                    Icons.notifications,
                                    color: Config.textWhite,
                                    size: 30,
                                  ),
                                ),
                                notifUnread != 0
                                    ? Positioned(
                                        right: 13,
                                        top: 11,
                                        child: new Container(
                                          padding: EdgeInsets.all(0),
                                          decoration: new BoxDecoration(
                                            color: Config.boxBlue,
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                          name ?? '-',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Config.textWhite),
                        ),
                        Text(
                          username ?? '-',
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
                    child: load
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Kelas Aktif',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Config.textWhite,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          dashboardGuruModel.kelasAktif
                                              .toString(),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fee Bulan Ini',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Config.textWhite,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          Config.formatRupiah(
                                              dashboardGuruModel.fee),
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
                                constraints: BoxConstraints(
                                    minHeight:
                                        dashboardGuruModel.kelasToday.length > 0
                                            ? 200
                                            : 20,
                                    maxHeight:
                                        dashboardGuruModel.kelasToday.length > 0
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3
                                            : 50),
                                child: dashboardGuruModel.kelasToday.length == 0
                                    ? Center(
                                        child: Text('Tidak ada kelas hari ini'))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        // physics: NeverScrollableScrollPhysics(),
                                        itemCount: dashboardGuruModel
                                            .kelasToday.length,
                                        // itemCount: 12,
                                        itemBuilder:
                                            (BuildContext cotext, int i) {
                                          if (dashboardGuruModel.kelasToday ==
                                              []) {
                                            return Text('Belum ada data kelas');
                                          } else {
                                            return ItemKelasTodayGuru(
                                              data: dashboardGuruModel
                                                  .kelasToday[i],
                                            );
                                          }
                                          // return Container(
                                          //   margin: EdgeInsets.only(top: 8),
                                          //   decoration: BoxDecoration(
                                          //       border: Border.all(
                                          //           width: 1,
                                          //           color: Config.borderInput),
                                          //       borderRadius:
                                          //           BorderRadius.circular(10)),
                                          //   child: Column(
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.start,
                                          //     children: [
                                          //       Container(
                                          //         margin: EdgeInsets.all(8),
                                          //         child: Row(
                                          //           mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .spaceBetween,
                                          //           children: [
                                          //             Text(
                                          //               ' widget.data.siswa',
                                          //               style: TextStyle(
                                          //                   fontWeight:
                                          //                       FontWeight.w900,
                                          //                   fontSize: 13),
                                          //             ),
                                          //             Text(
                                          //               'widget.data.mapel',
                                          //               style: TextStyle(
                                          //                   fontWeight:
                                          //                       FontWeight.w900,
                                          //                   fontSize: 13),
                                          //             )
                                          //           ],
                                          //         ),
                                          //       ),
                                          //       Divider(
                                          //         height: 1,
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Container(
                                          //             margin: EdgeInsets.all(8),
                                          //             child: Text(
                                          //               'widget.data.guru',
                                          //               style: TextStyle(
                                          //                   fontWeight:
                                          //                       FontWeight.w200,
                                          //                   fontSize: 13),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //       Container(
                                          //         margin: EdgeInsets.fromLTRB(
                                          //             8, 0, 8, 8),
                                          //         child: Row(
                                          //           mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .spaceBetween,
                                          //           children: [
                                          //             Row(
                                          //               children: [
                                          //                 FaIcon(
                                          //                   FontAwesomeIcons
                                          //                       .clock,
                                          //                   color: Config
                                          //                       .boxYellow,
                                          //                 ),
                                          //                 SizedBox(
                                          //                   width: 8,
                                          //                 ),
                                          //                 Text(
                                          //                   Config.formatJam(
                                          //                           '10.00') +
                                          //                       '-' +
                                          //                       Config.formatJam(
                                          //                           '12.00'),
                                          //                   style: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w900,
                                          //                     fontSize: 13,
                                          //                     color: Config
                                          //                         .boxYellow,
                                          //                   ),
                                          //                 ),
                                          //               ],
                                          //             ),
                                          //             Config.bedgeStatus(
                                          //                 'sharing')
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // );
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
                                  constraints: BoxConstraints(
                                      minHeight:
                                          dashboardGuruModel.sharing.length > 0
                                              ? 200
                                              : 20,
                                      maxHeight:
                                          dashboardGuruModel.sharing.length > 0
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3
                                              : 50),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    // itemCount: 20,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        dashboardGuruModel.sharing.length,
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
