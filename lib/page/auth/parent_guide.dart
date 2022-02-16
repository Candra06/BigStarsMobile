import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:bigstars_mobile/page/wali/mainPage.dart';
import 'package:bigstars_mobile/provider/rules_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyaratDanKetentuanWali extends StatefulWidget {
  const SyaratDanKetentuanWali({Key key}) : super(key: key);

  @override
  _SyaratDanKetentuanWaliState createState() => _SyaratDanKetentuanWaliState();
}

class _SyaratDanKetentuanWaliState extends State<SyaratDanKetentuanWali> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: Provider.of<RulesProvider>(context, listen: false).getDetail('?rules_for=Wali'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<RulesProvider>(
                builder: (context, value, child) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Teacher Guide Bigstars Jember',
                            style: TextStyle(fontSize: 18, color: Config.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Html(data: '''${value.rule.rules}'''),
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setString('setuju', 'true');
                            Navigator.of(context, rootNavigator: true).pushReplacement(PageTransition(
                                child: WaliMain(
                                  indexPage: '0',
                                ),
                                type: PageTransitionType.fade));
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
                            "Setuju",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
