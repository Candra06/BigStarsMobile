import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/page/guru/kelas/pageDetail.dart';
import 'package:bigstars_mobile/page/guru/kelas/pageKehadiran.dart';
import 'package:flutter/material.dart';

class DetailKelasGuru extends StatefulWidget {
  final String kelas;
  const DetailKelasGuru({Key key, this.kelas}) : super(key: key);

  @override
  _DetailKelasGuruState createState() => _DetailKelasGuruState();
}

class _DetailKelasGuruState extends State<DetailKelasGuru> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Config.textWhite,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Config.primary,
              )),
          title: new Text(
            "Detail Kelas",
            style: TextStyle(color: Config.primary),
          ),
          bottom: new TabBar(
            indicatorColor: Config.primary,
            labelColor: Config.primary,
            controller: controller,
            tabs: <Widget>[
              new Tab(
                text: "Detail",
              ),
              new Tab(
                text: "Kehadiran",
              ),
            ],
          ),
        ),
        body: TabBarView(controller: controller, children: <Widget>[
          DetailKelasPageGuru(
            id: widget.kelas,
          ),
          KehadiranKelasGuru(
            id: widget.kelas,
          ),
        ]));
  }
}
