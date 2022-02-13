import 'dart:convert';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/loadingButton.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/page/admin/mainPage.dart';
import 'package:bigstars_mobile/page/guru/mainPage.dart';
import 'package:bigstars_mobile/page/wali/mainPage.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  final String id;
  const ResetPassword({Key key, this.id}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var obsuced = true, retype = true;
  bool isLoading = false;
  Map<dynamic, dynamic> data;
  UserModel user;
  TextEditingController txtConfirm = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    submitLogin() async {
      setState(() {
        isLoading = true;
      });
      data = await authProvider.resetPassword(id: widget.id, password: txtConfirm.text);

      if (data["status"]) {
        setState(() {
          isLoading = false;
        });
        Config.alert(1, data['data']);
        Navigator.pushNamed(context, Routes.LOGIN);
      } else {
        Config.alert(1, data['message']);
        setState(() {
          print(data["message"]);
          isLoading = false;
        });
      }
    }

    Widget signIn() {
      return ElevatedButton(
        onPressed: () {
          if (txtPassword.text.isEmpty) {
            return Config.alert(0, 'Password tidak boleh kosong');
          } else if (txtConfirm.text != txtPassword.text) {
            return Config.alert(0, 'Password tidak sesuai');
          } else {
            submitLogin();
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
          "Reset Password",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Config.textBlack,
            )),
        title: Text(
          'Reset Password',
          style: TextStyle(color: Config.textBlack),
        ),
        backgroundColor: Config.textWhite,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Masukkan Password baru'),
              SizedBox(
                height: 20,
              ),
              Text('Password Baru'),
              Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          style: TextStyle(color: Colors.black54),
                          obscureText: obsuced,
                          keyboardType: TextInputType.text,
                          controller: txtPassword,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            fillColor: Colors.black54,
                            suffixIcon: IconButton(
                              color: Config.primary,
                              icon: obsuced ? Icon(Icons.lock_outline_rounded) : Icon(Icons.lock_open),
                              onPressed: () {
                                if (obsuced == true) {
                                  setState(() {
                                    obsuced = false;
                                  });
                                } else {
                                  setState(() {
                                    obsuced = true;
                                  });
                                }
                              },
                            ),
                            hintText: 'Masukkan password baru',
                            hintStyle: TextStyle(
                                // color: Config.textWhite,
                                fontSize: 16),
                            border: InputBorder.none,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Konfirmasi Password'),
              Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          style: TextStyle(color: Colors.black54),
                          obscureText: retype,
                          keyboardType: TextInputType.text,
                          controller: txtConfirm,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            fillColor: Colors.black54,
                            suffixIcon: IconButton(
                              color: Config.primary,
                              icon: retype ? Icon(Icons.lock_outline_rounded) : Icon(Icons.lock_open),
                              onPressed: () {
                                if (retype == true) {
                                  setState(() {
                                    retype = false;
                                  });
                                } else {
                                  setState(() {
                                    retype = true;
                                  });
                                }
                              },
                            ),
                            hintText: 'Masukkan konfirmasi password',
                            hintStyle: TextStyle(
                                // color: Config.textWhite,
                                fontSize: 16),
                            border: InputBorder.none,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 30,
              ),
              // signIn(),
              !isLoading ? signIn() : LoadingButton(),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.LOGIN);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  primary: Config.textWhite,
                  onPrimary: Config.textWhite,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: Config.primary)),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Config.primary, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
