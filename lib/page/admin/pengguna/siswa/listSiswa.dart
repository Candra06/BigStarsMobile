import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemSiswa.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  Expanded(
                    child: FutureBuilder(
                      future: Provider.of<SiswaProvider>(context, listen: false)
                          .getSiswa(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Consumer<SiswaProvider>(
                          builder: (context, data, _) {
                            return ListView.builder(
                              itemCount: data.listSiswa.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int i) {
                                return ItemListSiswa(
                                  data: data.listSiswa[i],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
