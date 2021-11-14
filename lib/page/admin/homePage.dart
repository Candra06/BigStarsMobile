import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
                            Icon(
                              Icons.person,
                              color: Config.textWhite,
                              size: 30,
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
                          'Admin',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Config.textWhite),
                        ),
                        Text(
                          'admin@bigstars.com',
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
                    // height: double.infinity,
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
                                    '30',
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
                                    '30',
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
                                    '30',
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
                                    '30',
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
                        Text('Master Data'),
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
                            Container(
                                height: 90,
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/icons/iconAbsensi.png'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Absensi')
                                  ],
                                )),
                            Container(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Finance'),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Container(
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
                            Container(
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
                            Container(
                                height: 90,
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/icons/iconReport.png'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Report')
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Kelas Hari Ini'),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (BuildContext cotext, int i) {
                                var data = {"id_kelas": 1, "siswa": "Kekeyi", "mapel": "Calistung", "spp": 32000, "jam_mulai": "15.00", "jam_selesai": "16.00", "guru": "Mr. Revo"};
                                return ItemKelas(
                                  data: data,
                                );
                              }),
                        )
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
