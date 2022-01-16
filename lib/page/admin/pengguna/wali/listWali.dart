import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemGuru.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemWali.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:bigstars_mobile/provider/wali_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListWali extends StatefulWidget {
  const ListWali({Key key}) : super(key: key);

  @override
  _ListWaliState createState() => _ListWaliState();
}

class _ListWaliState extends State<ListWali> {
  bool load = false;
  String searchString = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
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
                  Expanded(
                    child: FutureBuilder(
                      future: Provider.of<WaliProvider>(context, listen: false).getWalis(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Consumer<WaliProvider>(
                          builder: (conatext, data, _) {
                            if (data.waliModels.length == 0) {
                              return Center(
                                child: Text("Kosong"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.listWali.length,
                                itemBuilder: (BuildContext context, int i) {
                                  if (searchString != '') {
                                    return data.listWali[i].nama.toLowerCase().contains(searchString.toLowerCase())
                                        ? ItemListWali(
                                            wali: data.listWali[i],
                                          )
                                        : Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Data Tidak ditemukan'),
                                            ),
                                          );
                                  } else {
                                    return ItemListWali(
                                      wali: data.listWali[i],
                                    );
                                  }
                                },
                              );
                            }
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
