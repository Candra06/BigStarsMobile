import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/modal/addSiswaByWali.dart';
import 'package:flutter/material.dart';

class DetailWaliSiswa extends StatefulWidget {
  final String id;
  const DetailWaliSiswa({Key key, this.id}) : super(key: key);

  @override
  _DetailWaliSiswaState createState() => _DetailWaliSiswaState();
}

class _DetailWaliSiswaState extends State<DetailWaliSiswa> {
  void _addNewSiswa(BuildContext context, String id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalTambahSiswa(
            idWali: id,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Config.primary,
            )),
        title: Text(
          'Detail Wali Siswa',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(16), child: Text('Data Wali Siswa')),
          Config.itemDetail('Nama', 'Akexandria Angle'),
          Config.itemDetail('Alamat', 'Jember'),
          Config.itemDetail('Status', 'Active'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: EdgeInsets.all(16), child: Text('Data Akun')),
            ],
          ),
          Config.itemDetail('Username', 'alex_andria'),
          Config.itemDetail('Phone', '08983368286'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: EdgeInsets.all(16), child: Text('Data Siswa')),
              InkWell(
                onTap: () {
                  _addNewSiswa(context, widget.id);
                },
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Config.primary,
                        ),
                        Text('Tambah Siswa',
                            style: TextStyle(
                              color: Config.primary,
                            )),
                      ],
                    )),
              ),
            ],
          ),
          for (var i = 0; i < 2; i++) ...{
            Config.itemDetail('Indriana Saputri', '2005-03-30'),
          }
        ],
      ),
    );
  }
}
