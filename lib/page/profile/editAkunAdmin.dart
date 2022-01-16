import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAkunAdmin extends StatefulWidget {
  const EditAkunAdmin({Key key}) : super(key: key);

  @override
  _EditAkunAdminState createState() => _EditAkunAdminState();
}

class _EditAkunAdminState extends State<EditAkunAdmin> {
  DateTime _dateTime;
  String tglLahir;
  bool obsecured = true;
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  UserModel userModel = new UserModel();

  void edit() async {
    userModel.username = txtUsername.text;
    userModel.phone = txtPhone.text;
    userModel.password = txtPassword.text;
    await Provider.of<AuthProvider>(context, listen: false).editProfilAdmin(user: userModel).then((value) {
      if (value) {
        print(value);
        Config.alert(1, 'Berhasil merubah profil');
        Navigator.pushNamed(context, Routes.PROFILE_ADMIN);
      }
    });
  }

  void getData() async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      userModel = authProvider.user;
      txtUsername.text = authProvider.user.username;
      txtPhone.text = authProvider.user.phone;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this.getData();
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
              Text(
                'Kosongkan jika tidak ingin merubah password',
                style: TextStyle(fontStyle: FontStyle.italic, color: Config.textGrey),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // submit proses
                  if (txtUsername.text.isEmpty) {
                    Config.alert(0, 'Username tidak boleh kosong');
                  } else if (txtPhone.text.isEmpty) {
                    Config.alert(0, 'Username tidak boleh kosong');
                  } else {
                    edit();
                  }
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
