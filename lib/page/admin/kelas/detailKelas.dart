import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/page/admin/kelas/pageDetail.dart';
import 'package:bigstars_mobile/page/admin/kelas/pageKehadiran.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailKelas extends StatefulWidget {
  final KelasModel kelas;
  const DetailKelas({Key key, this.kelas}) : super(key: key);

  @override
  _DetailKelasState createState() => _DetailKelasState();
}

class _DetailKelasState extends State<DetailKelas> with SingleTickerProviderStateMixin {
  TabController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showConfirmHapus(int id) {
    showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/warning-animation.json',
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text('Are you sure to delete ?'),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.alertColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.boxGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // Navigator.pop(context);
                        // handleHapus();
                        await Provider.of<KelasProvider>(context, listen: false).deleteKelas(widget.kelas.id).then((value) {
                          print(value);
                          if (value == true) {
                            Config.alert(1, 'Berhasil menghapus kelas');
                            Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '1');
                            return true;
                          } else {
                            return false;
                          }
                        });
                      },
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Config.textWhite,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '1');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Config.primary,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  _showConfirmHapus(widget.kelas.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Config.primary,
                )),
          ],
          title: new Text(
            "Detail Kelas",
            style: TextStyle(color: Config.primary),
          ),
          bottom: new TabBar(
            indicatorColor: Config.primary,
            labelColor: Config.primary,
            controller: controller,
            tabs: <Widget>[
              new Tab(
                text: "Detail",
              ),
              new Tab(
                text: "Kehadiran",
              ),
            ],
          ),
        ),
        body: TabBarView(controller: controller, children: <Widget>[
          DetailKelasPage(
            kelas: widget.kelas,
          ),
          KehadiranKelas(
            kelas: widget.kelas,
          ),
        ]));
  }
}
