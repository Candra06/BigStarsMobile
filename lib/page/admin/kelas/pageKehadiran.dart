import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKehadiran.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranGuru.dart';
import 'package:flutter/material.dart';

class KehadiranKelas extends StatefulWidget {
  final String id;
  const KehadiranKelas({Key key, this.id}) : super(key: key);

  @override
  _KehadiranKelasState createState() => _KehadiranKelasState();
}

class _KehadiranKelasState extends State<KehadiranKelas> {
  bool load = false;
  void _addNewKehadiran(BuildContext context, String id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalTambahKehadiran(
            id: id,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primary,
          onPressed: () {
            _addNewKehadiran(context, widget.id);
          },
          child: Icon(
            Icons.add,
            color: Config.textWhite,
          )),
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
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int i) {
                    var data = {
                      'id': '1',
                      'nama': 'Revo',
                      'hari': 'Senin',
                      'status': 'Done',
                      'materi': 'Aljabar',
                      'jurnal': 'Lorem Ipsum Dolor',
                      'file_materi': 'urlfilemateri',
                    };
                    return ItemListKehadiran(
                      data: data,
                    );
                  }),
            ),
    );
  }
}