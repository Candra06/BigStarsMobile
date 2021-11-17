import 'package:bigstars_mobile/helper/config.dart';
import 'package:flutter/material.dart';

class DetailSiswa extends StatefulWidget {
  final String id;
  const DetailSiswa({Key key, this.id}) : super(key: key);

  @override
  _DetailSiswaState createState() => _DetailSiswaState();
}

class _DetailSiswaState extends State<DetailSiswa> {
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
        title: Text(
          'Detail Siswa',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: EdgeInsets.all(16), child: Text('Data Siswa')),
          Config.itemDetail('Nama', 'Akexandria Angle'),
          Config.itemDetail('Tanggal Lahir', Config.formatDateInput('2003-02-02')),
          Config.itemDetail('Alamat', 'Jember'),
          Config.itemDetail('Wali Siswa', 'John Jake'),
        ],
      ),
    );
  }
}
