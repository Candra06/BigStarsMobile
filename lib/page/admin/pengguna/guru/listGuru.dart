import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemGuru.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListGuru extends StatefulWidget {
  const ListGuru({Key key}) : super(key: key);

  @override
  _ListGuruState createState() => _ListGuruState();
}

class _ListGuruState extends State<ListGuru> {
  bool load = false;
  String searchString = "";
  List<GuruModel> guru;
  // getData() async {
  //   guru = await Provider.of<GuruProvider>(context, listen: false).getData();
  // }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primary,
          onPressed: () {
            var data = {"id": "0", "guru": GuruModel()};
            Navigator.pushNamed(context, Routes.ADD_GURU, arguments: data);
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
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Config.borderInput)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              style: TextStyle(color: Colors.black54),
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              // controller: controller,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.black54,
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Config.textGrey,
                                ),
                                hintText: 'Cari Nama',
                                hintStyle: TextStyle(
                                    // color: Config.textWhite,
                                    fontSize: 16),
                                border: InputBorder.none,
                              )),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: Provider.of<GuruProvider>(context, listen: false)
                          .getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return snapshot.hasData
                              ? Container(
                                  child: Consumer<GuruProvider>(
                                    builder: (context, data, _) {
                                      print(data);
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: data.listGuru.length,
                                        itemBuilder: (context, int i) {
                                          if (searchString != '') {
                                            return data.listGuru[i].nama
                                                    .toLowerCase()
                                                    .contains(searchString
                                                        .toLowerCase())
                                                ? ItemListGuru(
                                                    guru: data.listGuru[i],
                                                  )
                                                : Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          'Data Tidak ditemukan'),
                                                    ),
                                                  );
                                            // logic ketika pencarian berdasarkan nama
                                          } else {
                                            return ItemListGuru(
                                              guru: data.listGuru[i],
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text('Tidak ada data guru'),
                                );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
