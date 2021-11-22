import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListFee.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListFeeGuru extends StatefulWidget {
  const ListFeeGuru({Key key}) : super(key: key);

  @override
  _ListFeeGuruState createState() => _ListFeeGuruState();
}

class _ListFeeGuruState extends State<ListFeeGuru> {
  List<dynamic> _listSPP = [
    {"id": 1, "nama_siswa": "Ridho Ilahi", "spp": 1500000, "tanggal": "13-10-2021", "status": "Belum Lunas"},
    {"id": 2, "nama_siswa": "Inayah Larasati", "spp": 1500000, "tanggal": "13-10-2021", "status": "Lunas"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Config.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.filter,
              size: 20,
              color: Config.primary,
            ),
          ),
        ],
        backgroundColor: Config.textWhite,
        title: Text(
          "Fee Guru",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext bc, int i) {
              return ItemListFee();
            }),
      ),
    );
  }
}
