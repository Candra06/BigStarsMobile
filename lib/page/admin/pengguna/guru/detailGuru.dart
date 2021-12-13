import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:flutter/material.dart';

class DetailGuru extends StatefulWidget {
  final GuruModel guru;
  const DetailGuru({Key key, this.guru}) : super(key: key);

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
          Config.itemDetail('Nama', widget.guru.nama),
          Config.itemDetail(
              'Tanggal Lahir', Config.formatDateInput(widget.guru.birthDate)),
          Config.itemDetail('Alamat', widget.guru.alamat),
          Container(padding: EdgeInsets.all(16), child: Text('Data Akun')),
          Config.itemDetail('Username', widget.guru.username),
          Config.itemDetail('Telepon', widget.guru.phone),
        ],
      ),
    );
  }
}
