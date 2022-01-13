import 'package:bigstars_mobile/helper/config.dart';
// import 'package:bigstars_mobile/helper/route.dart';
// import 'package:bigstars_mobile/model/guru/kelas.dart';
// import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
// import 'package:bigstars_mobile/page/admin/listItem/itemListKelasGuru.dart';
import 'package:bigstars_mobile/page/guru/kelas/listItem.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
// import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

class ListKelasGuru extends StatefulWidget {
  const ListKelasGuru({Key key}) : super(key: key);

  @override
  _ListKelasGuruState createState() => _ListKelasGuruState();
}

class _ListKelasGuruState extends State<ListKelasGuru> {
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
  void initState() {
    super.initState();
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
        child: TileKelas(),
      ),
    );
  }
}
