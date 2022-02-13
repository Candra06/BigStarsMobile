import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/page/modal/addSiswaDialog.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EditKelasAdmin extends StatefulWidget {
  final KelasModel kelas;
  const EditKelasAdmin({Key key, this.kelas}) : super(key: key);

  @override
  _EditKelasAdminState createState() => _EditKelasAdminState();
}

class _EditKelasAdminState extends State<EditKelasAdmin> {
  DateTime _dateTime;
  String jamMulai, jamSelesai;
  List<Map<String, dynamic>> mapels = [];
  List<Map<String, dynamic>> guru = [];
  List<Map<String, dynamic>> siswa = [];

  TextEditingController txtFee = new TextEditingController();
  TextEditingController txtSpp = new TextEditingController();
  int valMapel, valGuru, valSiswa;

  bool load = false;

  void _showSuccesAdd() {
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
                  Text('Data has been created!'),
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

  void updateKelas() async {
    setState(() {
      Config.loading(context);
    });

    Map<String, dynamic> data = {
      "id_mapel": valMapel.toString(),
      "id_guru": valGuru.toString(),
      "id_siswa": valSiswa.toString(),
      "spp": txtSpp.text,
      "fee_guru": txtFee.text,
    };
    print(data);
    await Provider.of<KelasProvider>(context, listen: false).updateKelas(data, widget.kelas.id.toString()).then((value) {
      if (value) {
        _showSuccesAdd();
        setState(() {
          Navigator.pop(context);
          Config.alert(1, 'Berhasil mengubah kelas');
          Navigator.pushNamed(context, Routes.DETAIL_KELAS, arguments: widget.kelas);
        });
      }
    });
    // print(valHari);
  }

  void getData() async {
    setState(() {
      load = true;
    });

    List<MapelModel> mapelModels = await Provider.of<MapelProvider>(context, listen: false).getMapels();
    List<GuruModel> guruModels = await Provider.of<GuruProvider>(context, listen: false).getData();
    List<SiswaModel> siswaModels = await Provider.of<SiswaProvider>(context, listen: false).getSiswa();
    txtFee.text = widget.kelas.feeGuru;
    txtSpp.text = widget.kelas.spp;
    valGuru = int.parse(widget.kelas.idGuru.toString());
    valMapel = int.parse(widget.kelas.idMapel.toString());
    valSiswa = int.parse(widget.kelas.idSiswa.toString());
    // print(TimeOfDay.now());
    for (var i = 0; i < mapelModels.length; i++) {
      mapels.add({
        "id": mapelModels[i].id,
        "nama": mapelModels[i].mapel,
      });
    }
    for (var i = 0; i < guruModels.length; i++) {
      guru.add({
        "id": guruModels[i].id,
        "nama": guruModels[i].nama,
      });
    }

    for (var i = 0; i < siswaModels.length; i++) {
      siswa.add({
        "id": siswaModels[i].id,
        "nama": siswaModels[i].nama,
      });
    }

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
  void dispose() {
    getData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Config.primary,
          ),
        ),
        backgroundColor: Config.textWhite,
        title: Text(
          "Edit Kelas",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mata Pelajaran'),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                      child: DropdownButton(
                        underline: SizedBox(),
                        hint: Text(
                          "Pilih Pelajaran",
                          style: TextStyle(
                            color: Config.textGrey,
                          ),
                        ),
                        isExpanded: true,
                        value: valMapel,
                        items: mapels.map((value) {
                          return DropdownMenuItem(
                            child: Text(value["nama"]),
                            value: value["id"],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            valMapel = value;
                            print(valMapel);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Guru Pengajar'),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                      child: DropdownButton(
                        underline: SizedBox(),
                        hint: Text(
                          "Pilih Guru",
                          style: TextStyle(
                            color: Config.textGrey,
                          ),
                        ),
                        isExpanded: true,
                        value: valGuru,
                        items: guru.map((value) {
                          return DropdownMenuItem(
                            child: Text(value["nama"]),
                            value: value["id"],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            valGuru = value;
                            print(valGuru);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Siswa'),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                      child: DropdownButton(
                        underline: SizedBox(),
                        hint: Text(
                          "Pilih Siswa",
                          style: TextStyle(
                            color: Config.textGrey,
                          ),
                        ),
                        isExpanded: true,
                        value: valSiswa,
                        items: siswa.map((value) {
                          return DropdownMenuItem(
                            child: Text(value["nama"]),
                            value: value["id"],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            valSiswa = value;
                            print(valSiswa);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('SPP'),
                    formInputType(txtSpp, 'SPP', TextInputType.number),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Fee Guru'),
                    formInputType(txtFee, 'Fee Pengajar', TextInputType.number),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (valGuru == null) {
                          Config.alert(0, 'Guru tidak boleh kosong');
                        } else if (valSiswa == null) {
                          Config.alert(0, 'Siswa tidak boleh kosong');
                        } else if (valMapel == null) {
                          Config.alert(0, 'Mapel tidak boleh kosong');
                        } else if (txtSpp.text.isEmpty) {
                          Config.alert(0, 'SPP tidak boleh kosong');
                        } else if (txtFee.text.isEmpty) {
                          Config.alert(0, 'Fee Guru tidak boleh kosong');
                        } else {
                          updateKelas();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        primary: Config.primary,
                        onPrimary: Config.textWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
