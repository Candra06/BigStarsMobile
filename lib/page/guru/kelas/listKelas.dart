import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelasGuru.dart';
// import 'package:bigstars_mobile/helper/route.dart';
// import 'package:bigstars_mobile/model/guru/kelas.dart';
// import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
// import 'package:bigstars_mobile/page/admin/listItem/itemListKelasGuru.dart';
import 'package:bigstars_mobile/page/guru/kelas/listItem.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
// import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class ListKelasGuru extends StatefulWidget {
  const ListKelasGuru({Key key}) : super(key: key);

  @override
  _ListKelasGuruState createState() => _ListKelasGuruState();
}

class _ListKelasGuruState extends State<ListKelasGuru> {
  void _filters(BuildContext context, String id) {
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
      },
    );
  }

  void berhasil() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Config.primary,
        content: Text(
          "Data Mapel Berhasil ditambah",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<String> filter = [];
  String _filter = '';

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

  @override
  void initState() {
    super.initState();
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
                _filters(context, '1');
              },
              icon: Icon(
                FontAwesomeIcons.filter,
                size: 20,
                color: Config.primary,
              )),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: FutureBuilder(
          future: Provider.of<KelasProvider>(context, listen: false)
              .getKelas(filtered: _filter),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<KelasProvider>(
              builder: (context, data, _) => ListView.builder(
                  itemCount: data.allKelas.length,
                  itemBuilder: (BuildContext bc, int i) {
                    return ItemKelasGuru(
                      data: data.allKelas[i],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
