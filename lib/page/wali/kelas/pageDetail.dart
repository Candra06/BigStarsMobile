import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/page/modal/modalSharingKelas.dart';
import 'package:flutter/material.dart';

class DetailKelasPageWali extends StatefulWidget {
  final DetailKelasModel data;
  const DetailKelasPageWali({Key key, this.data}) : super(key: key);

  @override
  _DetailKelasPageWaliState createState() => _DetailKelasPageWaliState();
}

class _DetailKelasPageWaliState extends State<DetailKelasPageWali> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: EdgeInsets.all(16), child: Text('Data Kelas')),
                  Config.itemDetail('Nama Siswa', widget.data.data.siswa),
                  Config.itemDetail('Nama Guru', widget.data.data.guru),
                  Config.itemDetail('Mata Pelajaran', widget.data.data.mapel),
                  Config.itemDetail('SPP', Config.formatRupiah(int.parse(widget.data.data.spp.toString()))),
                  Config.itemDetail('Status', widget.data.data.status),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.all(16), child: Text('Jadwal')),
                    ],
                  ),
                  for (var i = 0; i < widget.data.hari.length; i++) ...{
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            color: Config.textWhite,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.data.hari[i].hari),
                                Row(
                                  children: [
                                    Text(
                                      Config.formatJam(widget.data.hari[i].jamMulai) + ' - ' + Config.formatJam(widget.data.hari[i].jamSelesai),
                                      style: TextStyle(color: Config.textGrey),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1)
                        ],
                      ),
                    )
                  }
                ],
              ),
            ),
    );
  }
}
