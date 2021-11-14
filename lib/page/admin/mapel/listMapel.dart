import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListMapel.dart';
import 'package:flutter/material.dart';

class ListMapel extends StatefulWidget {
  const ListMapel({Key key}) : super(key: key);

  @override
  _ListMapelState createState() => _ListMapelState();
}

class _ListMapelState extends State<ListMapel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Config.primary,
            )),
        title: Text(
          'Data Mapel',
          style: TextStyle(color: Config.primary),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primary,
          onPressed: () {
            Navigator.pushNamed(context, Routes.ADD_MAPEL, arguments: '0');
          },
          child: Icon(
            Icons.add,
            color: Config.textWhite,
          )),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int i) {
              return ItemListMapel(
                id: 1,
                mapel: 'Calistung',
              );
            }),
      ),
    );
  }
}
