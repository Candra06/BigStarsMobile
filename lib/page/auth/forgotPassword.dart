import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/loadingButton.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var obsuced = true;
  bool isLoading = false;
  Map<dynamic, dynamic> data;
  UserModel user;
  TextEditingController txtUsername = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    submitLogin() async {
      setState(() {
        isLoading = true;
      });
      data = await authProvider.forgotPassword(username: txtUsername.text);

      if (data["status"]) {
        setState(() {
          isLoading = false;
        });
        Config.alert(1, data['data']);
        Navigator.pushNamed(context, Routes.RESET_PASSWORD, arguments: data['id'].toString());
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
          if (txtUsername.text.isEmpty) {
            return Config.alert(0, 'Username tidak boleh kosong');
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
          "Kirim",
          style: TextStyle(color: Colors.white, fontSize: 20),
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
          'Lupa Password',
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
              Text('Masukkan username anda'),
              SizedBox(
                height: 20,
              ),
              Text('Username'),
              formInput(txtUsername, "Username"),
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
            ],
          ),
        ),
      ),
    );
  }
}
