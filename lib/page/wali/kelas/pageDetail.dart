import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/modal/modalSharingKelas.dart';
import 'package:flutter/material.dart';

class DetailKelasPageWali extends StatefulWidget {
  final String id;
  const DetailKelasPageWali({Key key, this.id}) : super(key: key);

  @override
  _DetailKelasPageWaliState createState() => _DetailKelasPageWaliState();
}

class _DetailKelasPageWaliState extends State<DetailKelasPageWali> {
  void _sharingKelas(BuildContext context, String id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalSharingKelas(
            id: id,
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
                  Config.itemDetail('Mata Pelajaran', 'Calistung'),
                  Config.itemDetail('SPP', Config.formatRupiah(30000)),
                  Config.itemDetail('Status', 'Active'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.all(16), child: Text('Jadwal')),
                    ],
                  ),
                  for (var i = 0; i < 2; i++) ...{
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
