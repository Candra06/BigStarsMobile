import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/kelas/pageDetail.dart';
import 'package:bigstars_mobile/page/admin/kelas/pageKehadiran.dart';
import 'package:bigstars_mobile/page/modal/addSiswaByWali.dart';
import 'package:flutter/material.dart';

class DetailKelas extends StatefulWidget {
  final String id;
  const DetailKelas({Key key, this.id}) : super(key: key);

  @override
  _DetailKelasState createState() => _DetailKelasState();
}

class _DetailKelasState extends State<DetailKelas> with SingleTickerProviderStateMixin {
  TabController controller;
  void _addNewSiswa(BuildContext context, String id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalTambahSiswa(
            idWali: id,
          );
        });
  }

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
          DetailKelasPage(
            id: widget.id,
          ),
          KehadiranKelas(
            id: widget.id,
          ),
        ]));
  }
}
