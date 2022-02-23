import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/detaiKelas_model.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/page/modal/addJadwal.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranAdmin.dart';
import 'package:bigstars_mobile/page/modal/modalSharingKelas.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailKelasPage extends StatefulWidget {
  final KelasModel kelas;
  const DetailKelasPage({Key key, this.kelas}) : super(key: key);

  @override
  _DetailKelasPageState createState() => _DetailKelasPageState();
}

class _DetailKelasPageState extends State<DetailKelasPage> {
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

  void _addNewJadwal(BuildContext context, String id, idJadwal) {
    void onSubmit(status) {
      if (status == true) {
        setState(() {
          getData();
        });
      }
    }

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
            onSubmit: onSubmit,
          );
        });
  }

  bool load = false;
  List<JadwalModel> jadwalModels = [];
  DetailKelasModel detailKelas;
  _showSuccesHapus() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              // height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/success-delete.json'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Data has been deleted!'),
                ],
              ),
            ),
            actions: [
              Container(
                width: double.infinity - 30,
                height: 60,
                decoration: BoxDecoration(
                  color: Config.boxGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  // textColor: Color(0xFF6200EE),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ACCEPT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  _showConfirmHapus(int id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/warning-animation.json',
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text('Are you sure to delete ?'),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.alertColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.boxGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        // handleHapus();
                        var ids = await Provider.of<KelasProvider>(context, listen: false).deleteJadwal(id).then((value) {
                          if (value) {
                            _showSuccesHapus();
                            getData();
                          }
                        });
                      },
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  _showConfirmUpdate(int id, String status) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/warning-animation.json',
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text('Apakah anda yakin akan mengubah status kelas ?'),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.alertColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.boxGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // print(status);
                        Navigator.pop(context);
                        // // handleHapus();
                        var ids = await Provider.of<KelasProvider>(context, listen: false).updateStatusKelas(id, status).then((value) {
                          // _showSuccesHapus();
                          // print(value);
                          Config.alert(1, 'Berhasil mengubah status kelas');
                          getData();
                        });
                      },
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  List<GuruModel> guruModels;
  List gurus = [];

  void getData() async {
    setState(() {
      load = true;
    });
    detailKelas = await Provider.of<KelasProvider>(context, listen: false).getDetailAdmin(widget.kelas.id);
    guruModels = await Provider.of<GuruProvider>(context, listen: false).getData();
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
                  Container(padding: EdgeInsets.all(16), child: Text('Data Kelas')),
                  Config.itemDetail('Nama Siswa', detailKelas.data.siswa ?? '-'),
                  Config.itemDetail('Nama Guru', detailKelas.data.guru ?? '-'),
                  Config.itemDetail('Mata Pelajaran', detailKelas.data.mapel ?? '-'),
                  Config.itemDetail('SPP', detailKelas.data.spp == null ? '-' : Config.formatRupiah(int.parse(detailKelas.data.spp))),
                  Config.itemDetail('Fee Guru', detailKelas.data.feeGuru == null ? '-' : Config.formatRupiah(int.parse(detailKelas.data.feeGuru))),
                  Config.itemDetail('Status', detailKelas.data.status ?? '-'),
                  InkWell(
                    onTap: () {
                      String tmpStatus;
                      tmpStatus = detailKelas.data.status == 'Active' ? 'Inactive' : 'Active';
                      _showConfirmUpdate(detailKelas.data.id, tmpStatus);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: detailKelas.data.status == 'Active' ? Config.textRed : Config.boxGreen),
                      child: Center(
                        child: Text(
                          detailKelas.data.status == 'Active' ? 'Nonaktifkan Kelas' : 'Aktifkan Kelas',
                          style: TextStyle(color: Config.textWhite),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _sharingKelas(context, widget.kelas.id.toString(), gurus);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 30),
                        primary: Config.primary,
                        onPrimary: Config.textWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.all(16), child: Text('Jadwal')),
                      InkWell(
                        onTap: () {
                          _addNewJadwal(context, detailKelas.data.id.toString(), '0');
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
                  for (var i = 0; i < detailKelas.hari.length; i++) ...{
                    InkWell(
                      onTap: () {
                        _addNewJadwal(context, detailKelas.data.id.toString(), i.toString());
                      },
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
                                      Config.formatJam(detailKelas.hari[i].jamMulai) + ' - ' + Config.formatJam(detailKelas.hari[i].jamSelesai),
                                      style: TextStyle(color: Config.textBlack),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // aksi delete
                                        _showConfirmHapus(detailKelas.hari[i].id);
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
