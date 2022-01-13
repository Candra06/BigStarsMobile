import 'package:bigstars_mobile/page/admin/listItem/itemListKelasGuru.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TileKelas extends StatelessWidget {
  const TileKelas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<KelasProvider>(context, listen: false).getKelas(),
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
    );
  }
}
