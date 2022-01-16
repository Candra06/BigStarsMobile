import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasWali.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListKelasWali extends StatefulWidget {
  const ListKelasWali({Key key}) : super(key: key);

  @override
  _ListKelasWaliState createState() => _ListKelasWaliState();
}

class _ListKelasWaliState extends State<ListKelasWali> {
  void _filter(BuildContext context, String id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalFilterKelas();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        automaticallyImplyLeading: false,
        title: Text(
          "Kelas",
          style: TextStyle(color: Config.primary),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _filter(context, '1');
              },
              icon: Icon(
                FontAwesomeIcons.filter,
                size: 20,
                color: Config.primary,
              )),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext bc, int i) {
              var data = {"id_kelas": 1, "siswa": "Kekeyi", "mapel": "Calistung", "spp": 32000, "jam_mulai": "15.00", "jam_selesai": "16.00", "guru": "Mr. Revo"};
              return ItemKelasWali(
                data: data,
              );
            }),
      ),
    );
  }
}