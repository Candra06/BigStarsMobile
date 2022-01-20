import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListKelas extends StatefulWidget {
  const ListKelas({Key key}) : super(key: key);

  @override
  _ListKelasState createState() => _ListKelasState();
}

class _ListKelasState extends State<ListKelas> {
  List<String> filter = [];
  String _filter = '';

  bool load = false;
  void modalFilter(BuildContext context) {
    void filtered(guru, siswa, status) async {
      if (siswa != '') {
        filter.removeWhere((element) => element.startsWith('siswa'));
        filter.add('siswa=' + siswa);
      }
      if (guru != '') {
        filter.removeWhere((element) => element.startsWith('guru'));
        filter.add('guru=' + guru);
      }
      if (status != '') {
        filter.removeWhere((element) => element.startsWith('status'));
        filter.add('status=' + status);
      }
      print(filter);
      setState(() {
        _filter = filter.join('&').toString();
      });
      // Provider.of<KelasProvider>(context, listen: false).getKelas(filtered: filter.join('&').toString());
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalFilterKelas(
            // id: id,
            onsubmit: filtered,
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        automaticallyImplyLeading: false,
        title: Text(
          "Kelas",
          style: TextStyle(color: Config.primary),
        ),
        actions: [
          IconButton(
              onPressed: () {
                filter = [];
                _filter = '';
                modalFilter(context);
              },
              icon: Icon(
                FontAwesomeIcons.filter,
                size: 20,
                color: Config.primary,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.ADD_KELAS);
              },
              icon: Icon(
                FontAwesomeIcons.plus,
                size: 20,
                color: Config.primary,
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: FutureBuilder(
            future: Provider.of<KelasProvider>(context, listen: false).getKelas(filtered: _filter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<KelasProvider>(
                builder: (context, data, _) {
                  if (data.allKelas.length == 0) {
                    return Center(
                      child: Text('Belum ada data kelas'),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: data.allKelas.length,
                        itemBuilder: (BuildContext bc, int i) {
                          return snapshot.hasData
                              ? ItemKelas(
                                  data: data.allKelas[i],
                                )
                              : Center(
                                  child: Text('Belum ada data kelas'),
                                );
                        });
                  }
                },
              );
            }),
      ),
    );
  }
}
