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
  String searchString = "";
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
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              style: TextStyle(color: Colors.black54),
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  searchString = value;
                                });
                              },
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
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int i) {
                          var data = {"id": '1', "nama": "Orel Revo", "phone": "087757898666"};
                          if (searchString != '') {
                            return Container();
                            // logic ketika pencarian berdasarkan nama
                          } else {
                            return ItemListGuru(
                              data: data,
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
