import 'dart:io';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddGuru extends StatefulWidget {
  final String id;
  final GuruModel guru;
  const AddGuru({
    Key key,
    this.guru,
    this.id,
  }) : super(key: key);

  @override
  _AddGuruState createState() => _AddGuruState();
}

class _AddGuruState extends State<AddGuru> {
  DateTime _dateTime;
  String tglLahir;
  bool obsecured = true;
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtAlamat = new TextEditingController();
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtTglLahir = new TextEditingController();

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
                  Lottie.asset('assets/lottie/success.json'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Berhasil menambah data guru!'),
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
                    return Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');
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

  _showSuccesUpdate() {
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
                  Text('Berhasil mengubah data guru!'),
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
                    return Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');
                    // Navigator.pop(context);
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

  saveGuru() {
    Provider.of<GuruProvider>(context, listen: false)
        .tambahGuru({'nama': txtNama.text, 'alamat': txtAlamat.text, 'birth_date': tglLahir, 'username': txtUsername.text, 'password': txtPassword.text, 'foto': '-', 'phone': txtPhone.text}).then(
            (value) => _showSuccesHapus());

    // print(tglLahir);
  }

  void saveEdit() async {
    Map<String, dynamic> data = {'nama': txtNama.text, 'alamat': txtAlamat.text, 'birth_date': tglLahir, 'username': txtUsername.text, 'foto': '-', 'phone': txtPhone.text, 'status': 'Active'};
    if (txtPassword.text.isNotEmpty) {
      data['password'] = txtPassword.text;
    }
    await Provider.of<GuruProvider>(context, listen: false).editGuru(widget.guru.id, data).then((value) {
      if (value) {
        print(value);
        _showSuccesUpdate();
      }
    });
  }

  void insertValEdit() {
    tglLahir = DateFormat("yyyy-MM-dd").format(widget.guru.birthDate);
    txtNama.text = widget.guru.nama;
    txtAlamat.text = widget.guru.alamat;
    txtTglLahir.text = DateFormat("yyyy-MM-dd").format(widget.guru.birthDate);
    txtPhone.text = widget.guru.phone;
    txtUsername.text = widget.guru.username;
  }

  @override
  void initState() {
    if (widget.guru.id != null) {
      insertValEdit();
    }
    super.initState();
  }

  Future backPress(BuildContext context) => Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return backPress(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Config.textWhite,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Config.primary,
              )),
          title: Text(
            widget.id == '0' ? 'Tambah Guru' : 'Edit Guru',
            style: TextStyle(color: Config.primary),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Lengkap'),
                formInput(txtNama, 'Nama Lengkap'),
                SizedBox(
                  height: 10,
                ),
                Text('Tanggal Lahir'),
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
                            controller: txtTglLahir,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Config.textGrey,
                                  ),
                                  onPressed: () {
                                    showDatePicker(context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime, firstDate: DateTime(1980), lastDate: DateTime.now()).then((date) {
                                      if (date != null) {
                                        setState(() {
                                          _dateTime = date;
                                          txtTglLahir.text = Config.formatDateInput(date.toString());
                                          var tgl = _dateTime.toString().split(' ');
                                          tglLahir = tgl[0].toString();
                                        });
                                      }
                                    });
                                  }),
                              border: InputBorder.none,
                              hintText: 'Tanggal Lahir',
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
                Text('Nomor Telepon'),
                formInputType(txtPhone, 'Telepon/WA', TextInputType.number),
                SizedBox(
                  height: 10,
                ),
                Text('Alamat'),
                formInputMultiline(txtAlamat, 'Alamat'),
                SizedBox(
                  height: 10,
                ),
                Text('Username'),
                formInput(txtUsername, 'Nama Lengkap'),
                SizedBox(
                  height: 10,
                ),
                Text('Password'),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            style: TextStyle(color: Colors.black54),
                            obscureText: obsecured,
                            keyboardType: TextInputType.text,
                            controller: txtPassword,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              fillColor: Colors.black54,
                              suffixIcon: IconButton(
                                color: Config.primary,
                                icon: obsecured ? Icon(Icons.lock_outline_rounded) : Icon(Icons.lock_open),
                                onPressed: () {
                                  if (obsecured == true) {
                                    setState(() {
                                      obsecured = false;
                                    });
                                  } else {
                                    setState(() {
                                      obsecured = true;
                                    });
                                  }
                                },
                              ),
                              hintText: widget.guru.id != null ? 'Password(Opsional)' : 'Password',
                              hintStyle: TextStyle(
                                  // color: Config.textWhite,
                                  fontSize: 16),
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // submit proses
                    widget.id == '0' ? saveGuru() : saveEdit();
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
