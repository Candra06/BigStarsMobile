import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListFee.dart';
import 'package:bigstars_mobile/page/modal/modalFilterFee.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListFeeGuru extends StatefulWidget {
  const ListFeeGuru({Key key}) : super(key: key);

  @override
  _ListFeeGuruState createState() => _ListFeeGuruState();
}

class _ListFeeGuruState extends State<ListFeeGuru> {
  void _filter(BuildContext context, String id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalFilterFee(
              // id: id,
              );
        });
  }

  List<dynamic> _listFEE = [
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
              _filter(context, '0');
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 30),
                  primary: Config.primary,
                  onPrimary: Config.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Generate Fee Guru",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _listFEE.length,
                itemBuilder: (BuildContext bc, int i) {
                  return ItemListFee();
                }),
          ],
        ),
      ),
    );
  }
}
