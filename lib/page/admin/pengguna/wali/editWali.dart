import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/model/wali_model.dart';
import 'package:bigstars_mobile/provider/wali_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EditWali extends StatefulWidget {
  final WaliModel wali;
  const EditWali({Key key, this.wali}) : super(key: key);

  @override
  _EditWaliState createState() => _EditWaliState();
}

class _EditWaliState extends State<EditWali> {
  String tglLahir;
  bool obsecured = true;
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  TextEditingController txtAlamat = new TextEditingController();
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  List status = ['Active', 'Inactive'];
  String valStatus;
  _showSuccesEdit() {
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
                  Text('Data has been Updated!'),
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

  void editWali() async {
    Map<String, dynamic> data = {
      "nama": txtNama.text,
      "birth_date": "1999-03-21",
      "status": valStatus,
      "phone": txtPhone.text,
      "alamat": txtAlamat.text,
      "password": txtPassword.text,
      "username": txtUsername.text,
    };
    Provider.of<WaliProvider>(context, listen: false)
        .editWali(widget.wali.id.toString(), data)
        .then((value) {
      if (value) {
        print(value);
        _showSuccesEdit();
      }
    });
  }

  void insertval() {
    valStatus = widget.wali.status;
    txtNama.text = widget.wali.nama;
    txtPhone.text = widget.wali.phone;
    txtAlamat.text = widget.wali.alamat;
    txtUsername.text = widget.wali.username;
  }

  @override
  void initState() {
    super.initState();
    insertval();
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
          'Edit Wali Siswa',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama'),
              formInput(txtNama, "widget.wali.nama"),
              SizedBox(
                height: 10,
              ),
              Text('Nomor Telepon'),
              formInput(txtPhone, 'Nomor Telepon/WA'),
              SizedBox(
                height: 10,
              ),
              Text('Alamat'),
              formInputMultiline(txtAlamat, 'Alamat'),
              SizedBox(
                height: 10,
              ),
              Text('Status Wali'),
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
                    "Status",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: valStatus,
                  items: status.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valStatus = value;
                    });
                  },
                ),
              ),
              Text('Username'),
              formInput(txtUsername, 'Username'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => editWali(),
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
