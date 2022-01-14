import 'dart:convert';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/loadingButton.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/page/admin/mainPage.dart';
import 'package:bigstars_mobile/page/guru/mainPage.dart';
import 'package:bigstars_mobile/page/wali/mainPage.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var obsuced = true;
  bool isLoading = false;
  Map<dynamic, dynamic> data;
  UserModel user;
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    submitLogin() async {
      setState(() {
        isLoading = true;
      });
      data = await authProvider.login(
          username: txtUsername.text, password: txtPassword.text);
      user = authProvider.user;
      if (data["status"]) {
        setState(() {
          print(data["message"]);
          isLoading = false;
        });
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', user.token);
        pref.setString('user', json.encode(user.toJson()));
        setState(() {
          Provider.of<MapelProvider>(context, listen: false).getMapels();
        });
        await Provider.of<FinanceProvider>(context, listen: false).getFinance();
        await Provider.of<AuthProvider>(context, listen: false).getDashboard();
        await Provider.of<GuruProvider>(context, listen: false).getData();
        await Provider.of<SiswaProvider>(context, listen: false).getSiswa();
        if (authProvider.user.role == 'Admin') {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: AdminMain(
                indexPage: '0',
              ),
              type: PageTransitionType.fade,
            ),
          );
        } else if (authProvider.user.role == 'Guru') {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: GuruMain(
                indexPage: '0',
              ),
              type: PageTransitionType.fade,
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: WaliMain(
                indexPage: '0',
              ),
              type: PageTransitionType.fade,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Config.alertColor,
            content: Text(
              "gagal login, cek ulang inputan !",
              textAlign: TextAlign.center,
            ),
          ),
        );
        setState(() {
          print(data["message"]);
          isLoading = false;
        });
      }
    }

    Widget signIn() {
      return ElevatedButton(
        onPressed: () {
          // if (txtUsername.text.isEmpty) {
          //   return Config.alert(0, 'Username tidak boleh kosong');
          // } else if (txtPassword.text.isEmpty) {
          //   return Config.alert(0, 'Password tidak boleh kosong');
          // } else {
          submitLogin();
          // }
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
          "Masuk",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: Image.asset('assets/images/logo_primary.png')),
              SizedBox(
                height: 20,
              ),
              Text(
                'Masuk',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Username'),
              formInput(txtUsername, "Username"),
              SizedBox(
                height: 20,
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
                          obscureText: obsuced,
                          keyboardType: TextInputType.text,
                          controller: txtPassword,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            fillColor: Colors.black54,
                            suffixIcon: IconButton(
                              color: Config.primary,
                              icon: obsuced
                                  ? Icon(Icons.lock_outline_rounded)
                                  : Icon(Icons.lock_open),
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
                            hintText: 'Password',
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
                height: 30,
              ),
              // signIn(),
              !isLoading ? signIn() : LoadingButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.whatsapp),
                      SizedBox(
                        width: 10,
                      ),
                      Text('0853-3510-1763')
                    ],
                  ),
                  Row(
                    children: [
                      Text('bigstars.jember'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(FontAwesomeIcons.instagram),
                    ],
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
