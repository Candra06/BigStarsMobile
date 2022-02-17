import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasWali.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListKelasWali extends StatefulWidget {
  const ListKelasWali({Key key}) : super(key: key);

  @override
  _ListKelasWaliState createState() => _ListKelasWaliState();
}

class _ListKelasWaliState extends State<ListKelasWali> {
  List<String> filter = [];
  String _filter = '';
  void filterModal(BuildContext context) {
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
            onsubmit: filtered,
          );
        });
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
      ),
      body: FutureBuilder(
        future: Provider.of<KelasProvider>(context, listen: false).getKelas(filtered: _filter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          } else {
            return Consumer<KelasProvider>(
              builder: (context, value, child) {
                return Container(
                  margin: EdgeInsets.all(16),
                  child: ListView.builder(
                      itemCount: value.allKelas.length,
                      itemBuilder: (BuildContext bc, int i) {
                        return ItemKelasWali(
                          data: value.allKelas[i],
                        );
                      }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
