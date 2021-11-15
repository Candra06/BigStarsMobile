import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/pengguna/guru/listGuru.dart';
import 'package:bigstars_mobile/page/admin/pengguna/siswa/listSiswa.dart';
import 'package:flutter/material.dart';

class PagePengguna extends StatefulWidget {
  const PagePengguna({Key key}) : super(key: key);

  @override
  _PagePenggunaState createState() => _PagePenggunaState();
}

class _PagePenggunaState extends State<PagePengguna> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Config.textWhite,
        automaticallyImplyLeading: false,
        title: new Text(
          "Data Pengguna",
          style: TextStyle(color: Config.primary),
        ),
        bottom: new TabBar(
          indicatorColor: Config.primary,
          labelColor: Config.primary,
          controller: controller,
          tabs: <Widget>[
            new Tab(
              text: "Guru",
            ),
            new Tab(
              text: "Walisiswa",
            ),
            new Tab(
              text: "Siswa",
            ),
          ],
        ),
      ),
      body: TabBarView(controller: controller, children: <Widget>[
        ListGuru(),
        ListGuru(),
        ListSiswa(),
      ]),
    );
  }
}
