import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/loadingButton.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ModalTambahKehadiran extends StatefulWidget {
  final String id;
  final void Function(bool) onsubmit;
  const ModalTambahKehadiran({Key key, this.id, this.onsubmit}) : super(key: key);

  @override
  _ModalTambahKehadiranState createState() => _ModalTambahKehadiranState();
}

class _ModalTambahKehadiranState extends State<ModalTambahKehadiran> {
  TextEditingController txtMateri = new TextEditingController();
  TextEditingController txtJurnal = new TextEditingController();
  TextEditingController txtTanggalKelas = new TextEditingController();
  DateTime _dateTime;
  String tglKelas;
  bool isLoading = false;
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
                  Lottie.asset('assets/lottie/success.json'),
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

  void success() {
    txtJurnal.text = "";
    txtMateri.text = "";
    txtTanggalKelas.text = "";
    _showSuccesAdd();
  }

  void addMateri() async {
    setState(() {
      isLoading = true;
    });
    Provider.of<KelasProvider>(context, listen: false).addKehadiran(
      widget.id,
      {"materi": txtMateri.text, "jurnal": txtJurnal.text, "tglKelas": tglKelas},
      
    ).then((value) => {
          if (value) {success()}
        });

    setState(() {
      isLoading = false;
      widget.onsubmit(true);
      Config.alert(1, "Berhasil menambah absensi");
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    children: [Text('Tambah Kehadiran', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))],
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
              Text('Tanggal Kelas'),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextField(
                          readOnly: true,
                          controller: txtTanggalKelas,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Config.textGrey,
                                ),
                                onPressed: () {
                                  showDatePicker(context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime, firstDate: DateTime(2020), lastDate: DateTime.now()).then((date) {
                                    if (date != null) {
                                      setState(() {
                                        _dateTime = date;
                                        txtTanggalKelas.text = Config.formatDateInput(date.toString());
                                        var tgl = _dateTime.toString().split(' ');
                                        tglKelas = tgl[0].toString();
                                        print(tglKelas);
                                      });
                                    }
                                  });
                                }),
                            border: InputBorder.none,
                            hintText: 'Tanggal Kelas',
                            hintStyle: TextStyle(color: Config.textGrey),
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4, top: 8),
                      decoration: BoxDecoration(color: Config.primary, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: isLoading
                          ? LoadingButton()
                          : TextButton(
                              onPressed: () {
                                addMateri();
                                // Navigator.pop(context);
                              },
                              child: Text(
                                'SIMPAN',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Config.textWhite),
                              ),
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
