import 'dart:io';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/fileUpload.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ModalTambahKehadiranGuru extends StatefulWidget {
  final String id;
  final ListKehadiran data;
  final void Function(bool) onSumbit;
  final String tipe;
  const ModalTambahKehadiranGuru({Key key, this.id, this.data, this.tipe, this.onSumbit}) : super(key: key);

  @override
  _ModalTambahKehadiranGuruState createState() => _ModalTambahKehadiranGuruState();
}

class _ModalTambahKehadiranGuruState extends State<ModalTambahKehadiranGuru> {
  TextEditingController txtMateri = new TextEditingController();
  TextEditingController txtJurnal = new TextEditingController();
  TextEditingController txtPoin = new TextEditingController();
  List<String> statusKelas = ['Done', 'Cancel'];
  PlatformFile _fileMateri;
  FileUpload _upload = new FileUpload();
  File tmpFile;
  String nameFile = "";
  String status;
  Map<String, dynamic> data;
  bool isLoading = false;
  Position currentPosition;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return Future.error('Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  cekPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Config.alert(0, 'Akses lokasi tidak aktif, silahkan aktifkan akses lokasi anda');
      return '0';
    } else if (permission == LocationPermission.deniedForever) {
      Config.alert(0, 'Akses lokasi tidak aktif, silahkan aktifkan akses lokasi anda');
      return '0';
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        Config.alert(0, 'Akses lokasi tidak aktif, silahkan aktifkan akses lokasi anda');
        return '0';
      }
    } else {
      return '1';
    }
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true).then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      // print(e);
    });
  }

  void getParams() async {
    _fileMateri = await _upload.uploadFile(
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xlsx',
        'xls',
        'pptx',
      ],
    );

    tmpFile = File(_fileMateri.path);
    setState(() {
      nameFile = tmpFile.path.split("/").last;
    });
  }

  Future addKehadiran() async {
    await Firebase.initializeApp();
    // print(currentPosition.latitude.toString());
    // print(currentPosition.longitude.toString());
    if (currentPosition == null || currentPosition == null) {
      Config.alert(0, 'Gagal mendapatkan lokasi anda saat ini');
    } else {
      data = {
        "materi": txtMateri.text,
        "jurnal": txtJurnal.text,
        "status": status,
        "poin": txtPoin.text ?? 0,
        'latitude': currentPosition.latitude.toString(),
        'longitude': currentPosition.longitude.toString()
      };

      if (tmpFile == null) {
        data["file_materi"] = '-';
      } else {
        data["file_materi"] = tmpFile;
      }

      Map<String, dynamic> value = await Provider.of<KelasProvider>(context, listen: false).addKehadiranGuru(widget.id, data);
      if (mounted) {
        if (value['status'] == true) {
          Config.alert(1, value['message']);
          Navigator.pop(context);
        } else {
          FirebaseCrashlytics.instance.crash();
          Config.alert(0, value['message']);
          // Navigator.pop(context);
        }
      }
    }
  }

  Future updateKehadiran() async {
    if (currentPosition == null || currentPosition == null) {
      Config.alert(0, 'Gagal mendapatkan lokasi anda saat ini');
    } else {
      data = {
        "materi": txtMateri.text,
        "jurnal": txtJurnal.text,
        "status": status,
        "poin": txtPoin.text ?? 0,
        'latitude': currentPosition.latitude.toString(),
        'longitude': currentPosition.longitude.toString()
      };

      if (tmpFile == null) {
        data["file_materi"] = '-';
      } else {
        data["file_materi"] = tmpFile;
      }
      Map<String, dynamic> value = await Provider.of<KelasProvider>(context, listen: false).updateKehadiranGuru(widget.id, data);

      if (value['status'] == true) {
        Config.alert(1, value['message']);
        Navigator.pop(context);
      } else {
        Config.alert(0, value['message']);
        // Navigator.pop(context);
      }
    }
  }

  getData() {
    if (widget.tipe == "Update") {
      txtMateri.text = widget.data.materi;
      txtJurnal.text = widget.data.jurnal;
      txtPoin.text = widget.data.poinSiswa.toString();
    }
  }

  @override
  void initState() {
    _determinePosition();
    getData();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget tombolSimpan() {
      return TextButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          var lokasi = cekPermission();
          if (lokasi.toString() == '0') {
            Config.alert(0, 'Tidak dapat menambah absensi');
          } else {
            if (widget.tipe == "Update") {
              await updateKehadiran();
            } else {
              await addKehadiran();
            }

            setState(() {
              isLoading = false;
              widget.onSumbit(true);
            });
          }
        },
        child: Text(
          'SIMPAN',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Config.textWhite),
        ),
      );
    }

    Widget tombolLoad() {
      return TextButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'LOADING',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Config.textWhite),
            ),
          ],
        ),
      );
    }

    return Container(
      // padding: EdgeInsets.all(16),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(color: Config.background, borderRadius: new BorderRadius.only(topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [Text(widget.tipe == 'Update' ? 'Update Kehadiran' : 'Tambah Kehadiran', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              Divider(
                height: 22,
              ),
              if (currentPosition == null || currentPosition == null) ...{
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.exclamationTriangle,
                      color: Colors.yellow,
                    ),
                    Container(margin: EdgeInsets.only(left: 20), child: Text('Lokasi belum didapatkan'))
                  ],
                )
              } else ...{
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                    ),
                    Container(margin: EdgeInsets.only(left: 20), child: Text('Lokasi berhasil didapatkan'))
                  ],
                )
              },
              SizedBox(height: 16),
              Text('Materi',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              formInputType(txtMateri, 'Materi', TextInputType.text),
              SizedBox(height: 8),
              Text('Jurnal Mengajar',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              formInputMultiline(txtJurnal, 'Deskripsi materi yang diajarkan'),
              SizedBox(height: 8),
              Text('Poin'),
              formInputType(txtPoin, 'Poin', TextInputType.number),
              SizedBox(
                height: 8,
              ),
              Text('Status Kelas'),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 10),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: Text(
                    "Pilih Status",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: status,
                  items: statusKelas.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('File Materi'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.075),
                child: Column(
                  children: [
                    FormInputFile(
                      onTap: () {
                        getParams();
                      },
                    ),
                    if (nameFile.isNotEmpty) ...{
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.file_copy),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              nameFile,
                            ),
                          ),
                        ],
                      ),
                    }
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 4, top: 8),
                    decoration: BoxDecoration(color: Config.primary, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: isLoading ? tombolLoad() : tombolSimpan(),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
