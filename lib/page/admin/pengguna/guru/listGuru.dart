import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemGuru.dart';
import 'package:flutter/material.dart';

class ListGuru extends StatefulWidget {
  const ListGuru({Key key}) : super(key: key);

  @override
  _ListGuruState createState() => _ListGuruState();
}

class _ListGuruState extends State<ListGuru> {
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
            Navigator.pushNamed(context, Routes.ADD_GURU, arguments: '0');
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
                    var data = {"id": '1', "nama": "Orel Revo", "phone": "087757898666"};
                    return ItemListGuru(
                      data: data,
                    );
                  }),
            ),
    );
  }
}
