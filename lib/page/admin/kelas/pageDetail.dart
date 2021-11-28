import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/modal/addJadwal.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranGuru.dart';
import 'package:flutter/material.dart';

class DetailKelasPage extends StatefulWidget {
  final String id;
  const DetailKelasPage({Key key, this.id}) : super(key: key);

  @override
  _DetailKelasPageState createState() => _DetailKelasPageState();
}

class _DetailKelasPageState extends State<DetailKelasPage> {
  void _addNewJadwal(BuildContext context, String id, idJadwal) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalJadwalMengajar(
            idKelas: id,
            idJadwal: idJadwal,
          );
        });
  }

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
                  Config.itemDetail('Nama Siswa', 'Akexandria Angle'),
                  Config.itemDetail('Nama Guru', 'Jember'),
                  Config.itemDetail('Mata Pelajaran', 'Active'),
                  Config.itemDetail('SPP', Config.formatRupiah(30000)),
                  Config.itemDetail('Fee Guru', Config.formatRupiah(30000)),
                  Config.itemDetail('Status', 'Active'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.all(16), child: Text('Jadwal')),
                      InkWell(
                        onTap: () {
                          _addNewJadwal(context, widget.id, '0');
                        },
                        child: Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Config.primary,
                                ),
                                Text('Tambah Jadwal',
                                    style: TextStyle(
                                      color: Config.primary,
                                    )),
                              ],
                            )),
                      ),
                    ],
                  ),
                  for (var i = 0; i < 2; i++) ...{
                    InkWell(
                      onTap: () {
                        _addNewJadwal(context, widget.id, i.toString());
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Config.textWhite,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Senin'),
                                Row(
                                  children: [
                                    Text(
                                      '15.00 - 16.00',
                                      style: TextStyle(color: Config.textGrey),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // aksi delete
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: Config.primary,
                                      ),
                                    )
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
