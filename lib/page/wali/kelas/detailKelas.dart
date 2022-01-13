import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/wali/kelas/pageDetail.dart';
import 'package:bigstars_mobile/page/wali/kelas/pageKehadiran.dart';
import 'package:flutter/material.dart';

class DetailKelasWali extends StatefulWidget {
  final String id;
  const DetailKelasWali({Key key, this.id}) : super(key: key);

  @override
  _DetailKelasWaliState createState() => _DetailKelasWaliState();
}

class _DetailKelasWaliState extends State<DetailKelasWali> with SingleTickerProviderStateMixin {
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
          DetailKelasPageWali(
            id: widget.id,
          ),
          KehadiranKelasWali(
            id: widget.id,
          ),
        ]));
  }
}
