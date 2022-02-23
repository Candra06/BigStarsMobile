import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKehadiran.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKehadiranWali.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranGuru.dart';
import 'package:flutter/material.dart';

class KehadiranKelasWali extends StatefulWidget {
  final KehadiranModel data;
  const KehadiranKelasWali({Key key, this.data}) : super(key: key);

  @override
  _KehadiranKelasWaliState createState() => _KehadiranKelasWaliState();
}

class _KehadiranKelasWaliState extends State<KehadiranKelasWali> {
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : Container(
              margin: EdgeInsets.only(
                top: 16,
              ),
              child: ListView.builder(
                  itemCount: widget.data.dataKehadiran.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ItemListKehadiranWali(
                      data: widget.data.dataKehadiran[i],
                    );
                  }),
            ),
    );
  }
}
