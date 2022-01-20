import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/detaiKelas_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/page/modal/modalSharingKelas.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailKelasPageGuru extends StatefulWidget {
  final KelasModel kelas;
  const DetailKelasPageGuru({Key key, this.kelas}) : super(key: key);

  @override
  _DetailKelasPageGuruState createState() => _DetailKelasPageGuruState();
}

class _DetailKelasPageGuruState extends State<DetailKelasPageGuru> {
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
  DetailKelas detailKelas;
  void getData() async {
    setState(() {
      load = true;
    });
    detailKelas = await Provider.of<KelasProvider>(context, listen: false)
        .getDetail(detailKelas.id.toString());
    print(detailKelas.guru);
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
                  Container(
                      padding: EdgeInsets.all(16), child: Text('Data Kelas')),
                  Config.itemDetail('Nama Siswa', detailKelas.guru),
                  Config.itemDetail('Nama Guru', detailKelas.guru),
                  Config.itemDetail('Mata Pelajaran', detailKelas.mapel),
                  Config.itemDetail('Status', detailKelas.status),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _sharingKelas(context, '1');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 30),
                        primary: Config.primary,
                        onPrimary: Config.textWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sharing Kelas",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.all(16), child: Text('Jadwal')),
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
