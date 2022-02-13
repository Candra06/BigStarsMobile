import 'dart:io';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/fileUpload.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class ModalTambahKehadiranGuru extends StatefulWidget {
  final String id;
  final void Function(bool) onSumbit;
  final String tipe;
  const ModalTambahKehadiranGuru({Key key, this.id, this.tipe, this.onSumbit}) : super(key: key);

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

  getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true).then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
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
    data = {
      "materi": txtMateri.text,
      "jurnal": txtJurnal.text,
      "status": status,
      "poin": txtPoin.text,
      'latitude': currentPosition.latitude.toString(),
      'longitude': currentPosition.longitude.toString()
    };
    bool value = await Provider.of<KelasProvider>(context, listen: false).addKehadiranGuru(widget.id, data, tmpFile);
  }

  @override
  void initState() {
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
          await addKehadiran();
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
          setState(() {
            widget.onSumbit(true);
          });
        },
        child: Text(
          'SIMPAN',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Config.textWhite),
        ),
      );
    }

    Widget tombolLoad() {
      return TextButton(
        onPressed: () async {},
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
              SizedBox(height: 8),
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
                      print(status);
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
