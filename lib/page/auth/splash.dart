import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  String token = '';

  void getData() async {
    var tmpToken = await Pref.getToken();
    print(tmpToken);
    if (tmpToken != null) {}
  }

  @override
  void initState() {
    super.initState();
    // getData();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () async {
      // Navigator.of(context).pushReplacement(PageTransition(child: LoginPage(), type: PageTransitionType.fade));
      String token = await Pref.getToken();

      if (token == '' || token == null) {
        Navigator.of(context).pushReplacement(PageTransition(child: LoginPage(), type: PageTransitionType.fade));
      } else {
        Navigator.pushNamed(context, Routes.HOME);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
