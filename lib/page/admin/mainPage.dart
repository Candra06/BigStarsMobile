import 'dart:io';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/finance/financePage.dart';
import 'package:bigstars_mobile/page/admin/homePage.dart';
import 'package:bigstars_mobile/page/admin/pengguna/mainPengguna.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminMain extends StatefulWidget {
  final String indexPage;
  const AdminMain({Key key, this.indexPage}) : super(key: key);

  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin?'),
            content: new Text('Ingin keluar dari aplikasi ini.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Tidak'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Iya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void page() {
    setState(() {
      currentIndex = int.parse(widget.indexPage);
    });
  }

  int currentIndex = 0, lasttab = 0;

  void incrementTab(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    page();
    super.initState();
  }

  final List<Widget> screens = [
    HomeAdmin(),
    Container(),
    FinancePage(),
    PagePengguna(),
  ];
  Widget currentScreen = HomeAdmin();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: Config.primary,
              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.home,
                    ),
                    title: new Text(
                      'Beranda',
                      style: TextStyle(),
                    )),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.graduationCap,
                    ),
                    title: new Text(
                      'Kelas',
                      style: TextStyle(),
                    )),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
                    title: new Text(
                      'Finance',
                      style: TextStyle(),
                    )),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.users),
                    title: new Text(
                      'Userrs',
                      style: TextStyle(),
                    ))
              ],
              onTap: (index) {
                setState(() {
                  lasttab = currentIndex;
                  currentIndex = index;
                  currentScreen = screens[index];
                });
              },
            )),
      ),
    );
  }
}
