import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListMapel.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMapel extends StatefulWidget {
  @override
  _ListMapelState createState() => _ListMapelState();
}

class _ListMapelState extends State<ListMapel> {
  var token;
  void getData() async {
    token = await Pref.getToken();
    print(token);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '0'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Config.textWhite,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '0');
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
            var data = {"id": "0", "mapel": MapelModel()};
            Navigator.pushNamed(context, Routes.ADD_MAPEL, arguments: data);
          },
          child: Icon(
            Icons.add,
            color: Config.textWhite,
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: FutureBuilder(
            future: Provider.of<MapelProvider>(context, listen: false).getMapels(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return RefreshIndicator(
                onRefresh: () {
                  return Provider.of<MapelProvider>(context, listen: false).getMapels();
                },
                child: Consumer<MapelProvider>(
                  builder: (context, data, _) => ListView.builder(
                      itemCount: data.mapels.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ItemListMapel(
                          mapelModel: data.mapels[i],
                        );
                      }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
// 
