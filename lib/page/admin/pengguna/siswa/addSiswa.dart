import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/loadingButton.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddSiswa extends StatefulWidget {
  final String id;
  const AddSiswa({Key key, this.id}) : super(key: key);

  @override
  _AddSiswaState createState() => _AddSiswaState();
}

class _AddSiswaState extends State<AddSiswa> {
  bool isloading = false;
  DateTime _dateTime;
  String tglLahir;
  bool obsecured = true;
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtNamaWali = new TextEditingController();
  TextEditingController txtAlamat = new TextEditingController();
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  TextEditingController txtReferal = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtTglLahir = new TextEditingController();
  _showSuccesCreate() {
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
                  Text('Data has been Created!'),
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

  addProcess() async {
    setState(() {
      isloading = true;
    });
    Map<String, dynamic> data = {
      'nama_siswa': txtNama.text,
      'birth_date': tglLahir,
      'nama_wali': txtNamaWali.text,
      'phone': txtPhone.text,
      'alamat': txtAlamat.text,
      'username': txtUsername.text,
      'password': txtPassword.text
    };
    if (txtReferal.text.isNotEmpty) {
      data['kode_referal'] = txtReferal.text;
    }
    await Provider.of<SiswaProvider>(context, listen: false).addSiswa(data).then((value) => {
          if (value["message"] == "Success") {_showSuccesCreate()} else {print("gagal")}
        });
    // print(data);
    txtNama.text = '';
    txtAlamat.text = '';
    txtNamaWali.text = '';
    txtPassword.text = '';
    txtPhone.text = '';
    txtTglLahir.text = '';
    txtUsername.text = '';
    Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');
    setState(() {
      isloading = false;
    });
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
          widget.id == '0' ? 'Tambah Siswa' : 'Edit Siswa',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Siswa'),
              formInput(txtNama, 'Nama Siswa'),
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
                                  showDatePicker(context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime, firstDate: DateTime(2000), lastDate: DateTime.now()).then((date) {
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
              Text('Nama Wali'),
              formInputType(txtNamaWali, 'Nama Walisiswa', TextInputType.text),
              SizedBox(
                height: 10,
              ),
              Text('Alamat'),
              formInputMultiline(txtAlamat, 'Alamat'),
              SizedBox(
                height: 10,
              ),
              Text('Kode Referal'),
              formInputType(txtReferal, 'Opsional', TextInputType.text),
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
              isloading
                  ? LoadingButton()
                  : ElevatedButton(
                      onPressed: () {
                        // submit proses
                        print("ok");
                        addProcess();
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
