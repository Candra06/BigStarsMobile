import 'package:bigstars_mobile/helper/config.dart';

import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListAbsensi extends StatefulWidget {
  final String id;
  const ListAbsensi({Key key, this.id}) : super(key: key);

  @override
  _ListAbsensiState createState() => _ListAbsensiState();
}

class _ListAbsensiState extends State<ListAbsensi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Config.primary,
              )),
          backgroundColor: Config.textWhite,
          // automaticallyImplyLeading: false,
          title: Text(
            "Data Absensi",
            style: TextStyle(color: Config.primary),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: FutureBuilder(
            future: Provider.of<KelasProvider>(context, listen: false).getAbsensi(widget.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              } else {
                return snapshot.hasData
                    ? Consumer<KelasProvider>(builder: (context, data, _) {
                        return ListView.builder(
                            itemCount: data.listAbsensi.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Card(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // widget.guru.nama, hari jam status siswa
                                              data.listAbsensi[i].nama,
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              // widget.guru.phone,
                                              Config.formatDateTime(data.listAbsensi[i].createdAt.toString()),
                                              style: TextStyle(fontSize: 13, color: Config.textGrey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              // widget.guru.nama, hari jam status siswa
                                              data.listAbsensi[i].status,
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              // widget.guru.phone,
                                              Config.formatDateTimeJam(data.listAbsensi[i].createdAt.toString()),
                                              style: TextStyle(fontSize: 13, color: Config.textGrey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      })
                    : Center(
                        child: Text('Belum ada data absensi'),
                      );
              }
            },
          ),
        ));
  }
}
