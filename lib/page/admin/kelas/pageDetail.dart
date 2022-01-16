import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/page/modal/addJadwal.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranAdmin.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
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
  List<JadwalModel> jadwalModels = [];
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

  void getData() async {
    setState(() {
      load = true;
    });
    jadwalModels = await Provider.of<KelasProvider>(context, listen: false).getDetail(widget.kelas.id);

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
                  Config.itemDetail('Nama Siswa', widget.kelas.siswa),
                  Config.itemDetail('Nama Guru', widget.kelas.guru),
                  Config.itemDetail('Mata Pelajaran', widget.kelas.mapel),
                  Config.itemDetail('SPP', Config.formatRupiah(int.parse(widget.kelas.spp))),
                  Config.itemDetail('Fee Guru', Config.formatRupiah(int.parse(widget.kelas.feeGuru))),
                  Config.itemDetail('Status', widget.kelas.status),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.all(16), child: Text('Jadwal')),
                      InkWell(
                        onTap: () {
                          _addNewJadwal(context, widget.kelas.id.toString(), '0');
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
                  for (var i = 0; i < jadwalModels.length; i++) ...{
                    InkWell(
                      onTap: () {
                        _addNewJadwal(context, widget.kelas.id.toString(), i.toString());
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Config.textWhite,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(jadwalModels[i].hari),
                                Row(
                                  children: [
                                    Text(
                                      Config.formatJam(jadwalModels[i].jamMulai) + ' - ' + Config.formatJam(jadwalModels[i].jamSelesai),
                                      style: TextStyle(color: Config.textBlack),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // aksi delete
                                        _showConfirmHapus(jadwalModels[i].id);
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
