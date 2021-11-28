import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:flutter/material.dart';

class AddKelasAdmin extends StatefulWidget {
  const AddKelasAdmin({Key key}) : super(key: key);

  @override
  _AddKelasAdminState createState() => _AddKelasAdminState();
}

class _AddKelasAdminState extends State<AddKelasAdmin> {
  DateTime _dateTime;
  String jamMulai, jamSelesai;
  List<String> mapel = [];
  List<String> guru = [];
  List<String> siswa = [];
  TextEditingController txtFee = new TextEditingController();
  TextEditingController txtSpp = new TextEditingController();
  TextEditingController txtMulai = new TextEditingController();
  TextEditingController txtSelesai = new TextEditingController();
  bool isChecked = false;
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
      body: SingleChildScrollView(
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
                    "Pilih Mata Pelajaran",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  // value: valStatus,
                  items: mapel.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  // onChanged: (value) {
                  //   setState(() {
                  //     valStatus = value;
                  //     print(valStatus);
                  //   });
                  // },
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
                  // value: valStatus,
                  items: mapel.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  // onChanged: (value) {
                  //   setState(() {
                  //     valStatus = value;
                  //     print(valStatus);
                  //   });
                  // },
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
                  // value: valStatus,
                  items: mapel.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  // onChanged: (value) {
                  //   setState(() {
                  //     valStatus = value;
                  //     print(valStatus);
                  //   });
                  // },
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
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = !isChecked;
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
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = !isChecked;
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
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = !isChecked;
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
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = !isChecked;
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
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = !isChecked;
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
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = !isChecked;
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
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = !isChecked;
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
                    constraints: BoxConstraints(minWidth: 75, maxWidth: MediaQuery.of(context).size.width * 0.4),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
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
                                initialTime: _dateTime == null ? TimeOfDay.now() : _dateTime,
                              ).then((time) {
                                if (time != null) {
                                  setState(() {
                                    // _dateTime = time;
                                    txtMulai.text = time.hour.toString() + ':' + time.minute.toString();
                                    jamMulai = time.hour.toString() + ':' + time.minute.toString() + ":00"; //value ini yg disimpan
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
                    constraints: BoxConstraints(minWidth: 75, maxWidth: MediaQuery.of(context).size.width * 0.4),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
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
                                initialTime: _dateTime == null ? TimeOfDay.now() : _dateTime,
                              ).then((time) {
                                if (time != null) {
                                  setState(() {
                                    // _dateTime = time;
                                    txtSelesai.text = time.hour.toString() + ':' + time.minute.toString();
                                    print(txtSelesai.text.toString());
                                    // var tgl = _dateTime.toString().split(' ');
                                    jamSelesai = time.hour.toString() + ':' + time.minute.toString() + ":00"; //value ini yg disimpan
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
                onPressed: () {},
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
