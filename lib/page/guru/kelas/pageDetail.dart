import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/detaiKelas_model.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/page/modal/modalSharingKelas.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailKelasPageGuru extends StatefulWidget {
  final String id;
  const DetailKelasPageGuru({Key key, this.id}) : super(key: key);

  @override
  _DetailKelasPageGuruState createState() => _DetailKelasPageGuruState();
}

class _DetailKelasPageGuruState extends State<DetailKelasPageGuru> {
  void berhasil() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Config.primary,
        content: Text(
          "Sharing Kelas Berhasil",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _sharingKelas(BuildContext context, String id, List gurus) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalSharingKelas(
            id: id,
            gurus: gurus,
            berhasil: berhasil,
          );
        });
  }

  String role;
  bool load = false;
  DetailKelasModel detailKelas;
  List<GuruModel> guruModels;
  List gurus = [];
  void getData() async {
    setState(() {
      load = true;
    });
    role = Provider.of<AuthProvider>(context, listen: false).user.role;
    detailKelas = await Provider.of<KelasProvider>(context, listen: false)
        .getDetail(widget.id.toString());
    guruModels =
        await Provider.of<GuruProvider>(context, listen: false).getData();
    // print(widget.gurus.length);
    int jumlahGuru = guruModels.length;
    setState(() {
      for (var i = 0; i < jumlahGuru; i++) {
        gurus.add({
          "id": guruModels[i].id.toString(),
          "nama": guruModels[i].nama,
        });
      }
    });
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
                  Config.itemDetail('Nama Siswa', detailKelas.data.siswa),
                  Config.itemDetail('Nama Guru', detailKelas.data.guru),
                  Config.itemDetail('Mata Pelajaran', detailKelas.data.mapel),
                  Config.itemDetail('Status', detailKelas.data.status),
                  role == "Guru"
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _sharingKelas(context, widget.id, gurus);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 30),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
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
                  for (var i = 0; i < detailKelas.hari.length; i++) ...{
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
                                Text(detailKelas.hari[i].hari),
                                Row(
                                  children: [
                                    Text(
                                      detailKelas.hari[i].jamMulai +
                                          ' - ' +
                                          detailKelas.hari[i].jamSelesai,
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
