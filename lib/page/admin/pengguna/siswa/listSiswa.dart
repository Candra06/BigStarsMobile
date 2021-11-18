import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemSiswa.dart';
import 'package:flutter/material.dart';

class ListSiswa extends StatefulWidget {
  const ListSiswa({Key key}) : super(key: key);

  @override
  _ListSiswaState createState() => _ListSiswaState();
}

class _ListSiswaState extends State<ListSiswa> {
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
            Navigator.pushNamed(context, Routes.ADD_SISWA, arguments: '0');
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
                  ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int i) {
                        var data = {"id": "1", "nama": "Kekeyi", "birth_date": "2007-05-06", "alamat": "Jl. Dr.Soutomo"};
                        return ItemListSiswa(
                          data: data,
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
