import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailSiswa extends StatefulWidget {
  final SiswaModel siswa;
  const DetailSiswa({Key key, this.siswa}) : super(key: key);

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
          Config.itemDetail('Nama', widget.siswa.nama),
          Config.itemDetail('Tanggal Lahir', Config.formatDateInput(widget.siswa.birthDate.toString())),
          Config.itemDetail('Alamat', widget.siswa.alamat),
          Config.itemDetail('Wali Siswa', widget.siswa.wali),
          Column(
            children: [
              Container(
                color: Config.textWhite,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kode Referal'),
                    Row(
                      children: [
                        Text(
                          widget.siswa.kodeReferal,
                          style: TextStyle(color: Config.textBlack, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: widget.siswa.kodeReferal));
                              Config.alert(1, 'Kode referal telah disalin');
                            },
                            icon: Icon(Icons.copy))
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 1)
            ],
          )
        ],
      ),
    );
  }
}
