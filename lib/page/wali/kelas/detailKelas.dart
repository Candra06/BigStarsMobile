import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/page/wali/kelas/pageDetail.dart';
import 'package:bigstars_mobile/page/wali/kelas/pageKehadiran.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailKelasWali extends StatefulWidget {
  final String id;
  const DetailKelasWali({Key key, this.id}) : super(key: key);

  @override
  _DetailKelasWaliState createState() => _DetailKelasWaliState();
}

class _DetailKelasWaliState extends State<DetailKelasWali> with SingleTickerProviderStateMixin {
  TabController controller;
  KehadiranModel _kehadiran;
  DetailKelasModel _kelasModel;
  bool load = true;

  void getData() async {
    setState(() {
      load = true;
    });
    _kelasModel = await Provider.of<KelasProvider>(context, listen: false).getDetail(widget.id);
    _kehadiran = await Provider.of<KelasProvider>(context, listen: false).getKehadiran(widget.id);
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    getData();
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
        body: load
            ? LinearProgressIndicator()
            : TabBarView(controller: controller, children: <Widget>[
                DetailKelasPageWali(
                  data: _kelasModel,
                ),
                KehadiranKelasWali(
                  data: _kehadiran,
                ),
              ]));
  }
}
