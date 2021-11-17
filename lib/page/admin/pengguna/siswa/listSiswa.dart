import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemGuru.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemSiswa.dart';
import 'package:flutter/material.dart';

class ListSiswa extends StatefulWidget {
  const ListSiswa({Key key}) : super(key: key);

  @override
  _ListSiswaState createState() => _ListSiswaState();
}

class _ListSiswaState extends State<ListSiswa> {
  bool load = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primary,
          onPressed: () {
            // Navigator.pushNamed(context, Routes.ADD_MAPEL, arguments: '0');
          },
          child: Icon(
            Icons.add,
            color: Config.textWhite,
          )),
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int i) {
                    var data = {"id": "1", "nama": "Kekeyi", "birth_date": "2007-05-06", "alamat": "Jl. Dr.Soutomo"};
                    return ItemListSiswa(
                      data: data,
                    );
                  }),
            ),
    );
  }
}
