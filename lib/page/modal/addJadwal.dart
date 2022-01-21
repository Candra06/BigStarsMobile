import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ModalJadwalMengajar extends StatefulWidget {
  final String idKelas;
  final String idJadwal;
  const ModalJadwalMengajar({Key key, this.idKelas, this.idJadwal})
      : super(key: key);

  @override
  _ModalJadwalMengajarState createState() => _ModalJadwalMengajarState();
}

class _ModalJadwalMengajarState extends State<ModalJadwalMengajar> {
  List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jum`at',
    'Sabtu',
    'Minggu'
  ];
  DateTime _dateTime;
  String jamMulai, jamSelesai, valHari;

  TextEditingController txtMulai = new TextEditingController();
  TextEditingController txtSelesai = new TextEditingController();

  _showSuccesAdd() {
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
                  Text('Data has been added!'),
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

  void addJadwal() async {
    Map<String, dynamic> data = {
      "hari": valHari,
      "jam_mulai": jamMulai,
      "jam_selesai": jamSelesai,
      "id_jadwal": widget.idJadwal,
    };
    bool status = await Provider.of<KelasProvider>(context, listen: false)
        .addJadwal(widget.idKelas, data);
    if (status) {
      txtMulai.text = "";
      txtSelesai.text = "";
      _showSuccesAdd();
      Navigator.pop(context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
          color: Config.background,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
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
                    children: [
                      Text(
                          widget.idJadwal == '0'
                              ? 'Tambah Jadwal'
                              : 'Edit Jadwal',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))
                    ],
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
              Text('Hari',
                  style: TextStyle(
                    fontSize: 14,
                  )),
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
                    "Pilih Hari",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: valHari,
                  items: hari.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valHari = value;
                      print(valHari);
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              Text('Jam'),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    constraints: BoxConstraints(
                        minWidth: 75,
                        maxWidth: MediaQuery.of(context).size.width * 0.4),
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
                                initialEntryMode: TimePickerEntryMode.input,
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
                        maxWidth: MediaQuery.of(context).size.width * 0.4),
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
                                initialEntryMode: TimePickerEntryMode.input,
                                initialTime: _dateTime == null
                                    ? TimeOfDay.now()
                                    : _dateTime,
                              ).then((time) {
                                if (time != null) {
                                  setState(() {
                                    // _dateTime = time;
                                    txtSelesai.text = time.hour.toString() +
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
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 4, top: 8),
                    decoration: BoxDecoration(
                        color: Config.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          addJadwal();
                        },
                        child: Text('SIMPAN',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Config.textWhite))),
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
