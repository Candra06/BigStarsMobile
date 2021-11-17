import 'package:bigstars_mobile/helper/config.dart';
import 'package:flutter/material.dart';

class DetailGuru extends StatefulWidget {
  final String id;
  const DetailGuru({Key key, this.id}) : super(key: key);

  @override
  _DetailGuruState createState() => _DetailGuruState();
}

class _DetailGuruState extends State<DetailGuru> {
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
          'Detail Guru',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: EdgeInsets.all(16), child: Text('Data Guru')),
          Config.itemDetail('Nama', 'Akexandria Angle'),
          Config.itemDetail('Tanggal Lahir', Config.formatDateInput('2003-02-02')),
          Config.itemDetail('Alamat', 'Jember'),
          Container(padding: EdgeInsets.all(16), child: Text('Data Akun')),
          Config.itemDetail('Username', 'John Jake'),
          Config.itemDetail('Telepon', '08983368286'),
        ],
      ),
    );
  }
}
