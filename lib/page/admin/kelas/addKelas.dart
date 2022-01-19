import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddKelasAdmin extends StatefulWidget {
  const AddKelasAdmin({Key key}) : super(key: key);

  @override
  _AddKelasAdminState createState() => _AddKelasAdminState();
}

class _AddKelasAdminState extends State<AddKelasAdmin> {
  DateTime _dateTime;
  String jamMulai, jamSelesai;
  List<Map<String, dynamic>> mapels = [];
  List<Map<String, dynamic>> guru = [];
  List<Map<String, dynamic>> siswa = [];

  TextEditingController txtFee = new TextEditingController();
  TextEditingController txtSpp = new TextEditingController();
  TextEditingController txtMulai = new TextEditingController();
  TextEditingController txtReferal = new TextEditingController();
  TextEditingController txtSelesai = new TextEditingController();
  int valMapel, valGuru, valSiswa;
  String valHari;

  List<bool> checkHari = [false, false, false, false, false, false, false];
  List<String> dataHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jum'at",
    "Sabtu",
    "Minggu"
  ];

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

  void addKelas() async {
    setState(() {
      Config.loading(context);
    });
    List temp = [];
    for (var i = 0; i < checkHari.length; i++) {
      if (checkHari[i]) {
        temp.add(dataHari[i]);
      }
    }
    valHari = temp.join(",");
    Map<String, dynamic> data = {
      "id_mapel": valMapel.toString(),
      "id_guru": valGuru.toString(),
      "id_siswa": valSiswa.toString(),
      "spp": txtSpp.text,
      "fee_guru": txtFee.text,
      "hari": valHari,
      "jam_mulai": txtMulai.text,
      "jam_selesai": txtSelesai.text,
    };
    print(data);
    await Provider.of<KelasProvider>(context, listen: false)
        .addKelas(data)
        .then((value) {
      if (value) {
        _showSuccesAdd();
        setState(() {
          Navigator.pop(context);
          Config.alert(1, 'Berhasil menambah kelas');
          Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '1');
        });
      }
    });
    // print(valHari);
    setState(() {
      temp = [];
      checkHari = [false, false, false, false, false, false, false];
    });
  }

  void getData() async {
    setState(() {
      load = true;
    });

    List<MapelModel> mapelModels =
        await Provider.of<MapelProvider>(context, listen: false).getMapels();

    List<GuruModel> guruModels =
        await Provider.of<GuruProvider>(context, listen: false).getData();
    List<SiswaModel> siswaModels =
        await Provider.of<SiswaProvider>(context, listen: false).getSiswa();

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
    // TODO: implement dispose
    // getData();
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
          "Tambah Kelas",
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Config.borderInput)),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Config.borderInput)),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Config.borderInput)),
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
                    Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Config.primary,
                        ),
                        Text(
                          'Tambah Siswa Baru',
                          style: TextStyle(color: Config.primary),
                        ),
                      ],
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
                    Text('Hari'),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Config.primary,
                                value: checkHari[0],
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHari[0] = !checkHari[0];
                                  });
                                },
                              ),
                              Text('Senin'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Config.primary,
                                value: checkHari[1],
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHari[1] = !checkHari[1];
                                  });
                                },
                              ),
                              Text('Selasa'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Config.primary,
                                value: checkHari[2],
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHari[2] = !checkHari[2];
                                  });
                                },
                              ),
                              Text('Rabu'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Config.primary,
                                value: checkHari[3],
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHari[3] = !checkHari[3];
                                  });
                                },
                              ),
                              Text('Kamis'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Config.primary,
                                value: checkHari[4],
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHari[4] = !checkHari[4];
                                  });
                                },
                              ),
                              Text('Jum`at'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Config.primary,
                                value: checkHari[5],
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHari[5] = !checkHari[5];
                                  });
                                },
                              ),
                              Text('Sabtu'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Config.primary,
                          value: checkHari[6],
                          onChanged: (bool value) {
                            setState(() {
                              checkHari[6] = !checkHari[6];
                            });
                          },
                        ),
                        Text('Minggu'),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Jam'),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          constraints: BoxConstraints(
                              minWidth: 75,
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.4),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Config.borderInput)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  controller: txtMulai,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: 'Jam Mulai',
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    showTimePicker(
                                      context: context,
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                      initialTime: _dateTime == null
                                          ? TimeOfDay.now()
                                          : _dateTime,
                                    ).then((time) {
                                      if (time != null) {
                                        setState(() {
                                          // _dateTime = time;
                                          txtMulai.text = time.hour.toString() +
                                              ':' +
                                              time.minute.toString();
                                          jamMulai = time.hour.toString() +
                                              ':' +
                                              time.minute.toString() +
                                              ":00"; //value ini yg disimpan
                                        });
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text('S/d'),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          constraints: BoxConstraints(
                              minWidth: 75,
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.4),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Config.borderInput)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  controller: txtSelesai,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: 'Jam Selesai',
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    showTimePicker(
                                      context: context,
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                      initialTime: _dateTime == null
                                          ? TimeOfDay.now()
                                          : _dateTime,
                                    ).then((time) {
                                      if (time != null) {
                                        setState(() {
                                          // _dateTime = time;
                                          txtSelesai.text =
                                              time.hour.toString() +
                                                  ':' +
                                                  time.minute.toString();
                                          print(txtSelesai.text.toString());
                                          // var tgl = _dateTime.toString().split(' ');
                                          jamSelesai = time.hour.toString() +
                                              ':' +
                                              time.minute.toString() +
                                              ":00"; //value ini yg disimpan
                                        });
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addKelas();
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
