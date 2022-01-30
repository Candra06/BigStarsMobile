import 'dart:convert';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditAkunGuru extends StatefulWidget {
  const EditAkunGuru({Key key}) : super(key: key);
  @override
  _EditAkunGuruState createState() => _EditAkunGuruState();
}

class _EditAkunGuruState extends State<EditAkunGuru> {
  DateTime _dateTime;
  String tglLahir;
  bool obsecured = true;
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtAlamat = new TextEditingController();
  TextEditingController txtTglLahir = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  UserModel userModel;

  @override
  void initState() {
    userModel = Provider.of<AuthProvider>(context, listen: false).user;
    txtUsername.text = userModel.username;
    txtNama.text = userModel.nama;
    txtAlamat.text = userModel.alamat;
    final DateFormat formatter = DateFormat('dd MM yyyy');
    txtTglLahir.text = formatter.format(userModel.birthDate);
    txtPhone.text = userModel.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Edit Akun',
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Config.borderInput)),
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
                                  showDatePicker(
                                          context: context,
                                          initialDate: _dateTime == null
                                              ? DateTime.now()
                                              : _dateTime,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime.now())
                                      .then((date) {
                                    if (date != null) {
                                      setState(() {
                                        _dateTime = date;
                                        txtTglLahir.text =
                                            Config.formatDateInput(
                                                date.toString());
                                        var tgl =
                                            _dateTime.toString().split(' ');
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
              Text('Nomor Telepon'),
              formInputType(txtPhone, 'Telepon/WA', TextInputType.number),
              SizedBox(
                height: 10,
              ),
              Text('Password'),
              Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Config.borderInput)),
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
                              icon: obsecured
                                  ? Icon(Icons.lock_outline_rounded)
                                  : Icon(Icons.lock_open),
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
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                // color: Config.textWhite,
                                fontSize: 16),
                            border: InputBorder.none,
                          )),
                    ),
                  ],
                ),
              ),
              Text(
                'Kosongkan jika tidak ingin merubah password',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Config.textGrey),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // submit proses
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
    );
  }
}
