import 'dart:convert';

import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/page/admin/mainPage.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:bigstars_mobile/page/maps.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  String token = '';
  UserModel userModel;
  AuthProvider authProvider;
  void getData() async {
    var tmpToken = await Pref.getToken();
    var user = await Pref.getUserModel();
    // print(tmpToken);
    if (tmpToken != null) {
      await Provider.of<MapelProvider>(context, listen: false).getMapels();
      userModel = UserModel.fromJson(json.decode(user));
      Provider.of<AuthProvider>(context, listen: false).setUser(userModel);
      await Provider.of<FinanceProvider>(context, listen: false).getFinance();
    }
  }

  @override
  void initState() {
    getData();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () async {
      // Navigator.of(context).pushReplacement(PageTransition(child: GoogleMapsView(), type: PageTransitionType.fade));
      String token = await Pref.getToken();

      if (token == '' || token == null) {
        Navigator.of(context).pushReplacement(
            PageTransition(child: LoginPage(), type: PageTransitionType.fade));
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: AdminMain(
              indexPage: '0',
            ),
            type: PageTransitionType.fade,
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // authProvider = Provider.of<AuthProvider>(context);
    // authProvider.setUser(userModel);
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/logo_primary.png',
                    height: 190.0,
                    width: 190.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
