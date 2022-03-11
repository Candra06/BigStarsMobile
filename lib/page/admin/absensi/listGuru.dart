import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListGuruAbsensi extends StatefulWidget {
  const ListGuruAbsensi({Key key}) : super(key: key);

  @override
  _ListGuruAbsensiState createState() => _ListGuruAbsensiState();
}

class _ListGuruAbsensiState extends State<ListGuruAbsensi> {
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
        // automaticallyImplyLeading: false,
        title: Text(
          "Data Guru",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: FutureBuilder(
          future: Provider.of<GuruProvider>(context, listen: false).getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
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
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.DATA_GURU_ABSENSI_DETAIL, arguments: data.listGuru[i].id.toString());
                                },
                                child: Container(
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
                                                data.listGuru[i].nama,
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                              ),
                                              Text(
                                                data.listGuru[i].phone,
                                                style: TextStyle(fontSize: 13, color: Config.textGrey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
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
    );
  }
}
