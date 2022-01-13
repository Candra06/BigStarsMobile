import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListKelas extends StatefulWidget {
  const ListKelas({Key key}) : super(key: key);

  @override
  _ListKelasState createState() => _ListKelasState();
}

class _ListKelasState extends State<ListKelas> {
  void _filter(BuildContext context, String id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalFilterKelas(
              // id: id,
              );
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
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.ADD_KELAS);
              },
              icon: Icon(
                FontAwesomeIcons.plus,
                size: 20,
                color: Config.primary,
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: FutureBuilder(
            future:
                Provider.of<KelasProvider>(context, listen: false).getKelas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<KelasProvider>(
                builder: (context, data, _) => ListView.builder(
                    itemCount: data.allKelas.length,
                    itemBuilder: (BuildContext bc, int i) {
                      return ItemKelas(
                        data: data.allKelas[i],
                      );
                    }),
              );
            }),
      ),
    );
  }
}
