import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/page/admin/homePage.dart';
import 'package:bigstars_mobile/page/admin/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var obsuced = true;

  void submitLogin() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: AdminMain(
              indexPage: '0',
            ),
            type: PageTransitionType.fade));
  }

  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(
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
              ),
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
