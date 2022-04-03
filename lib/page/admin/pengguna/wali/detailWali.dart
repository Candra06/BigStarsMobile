import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/detailWali_model.dart';
import 'package:bigstars_mobile/model/wali_model.dart';
import 'package:bigstars_mobile/page/modal/addSiswaByWali.dart';
import 'package:bigstars_mobile/provider/wali_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailWaliSiswa extends StatefulWidget {
  final WaliModel wali;
  const DetailWaliSiswa({Key key, this.wali}) : super(key: key);

  @override
  _DetailWaliSiswaState createState() => _DetailWaliSiswaState();
}

class _DetailWaliSiswaState extends State<DetailWaliSiswa> {
  void _addNewSiswa(BuildContext context) {
    void respon(res) {
      if (res == true) {
        setState(() {
          Navigator.pushNamed(context, Routes.DETAIL_WALI, arguments: widget.wali);
        });
      }
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalTambahSiswa(
            idWali: widget.wali.id.toString(),
            respon: respon,
          );
        });
  }

  void _konfirmasi() async {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Apakah anda yakin?'),
        content: new Text('Ingin menghapus data wali?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Tidak'),
          ),
          new FlatButton(
            onPressed: () {
              konfirmasi();
              Navigator.of(context).pop(false);
            },
            child: new Text('Iya'),
          ),
        ],
      ),
    );
  }

  void konfirmasi() async {
    bool status = await Provider.of<WaliProvider>(context, listen: false).deleteWali(widget.wali.id.toString());
    if (status) {
      Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');
      Config.alert(1, 'Berhasil menghapus data wali');
      // _showSucces();
    } else {
      Config.alert(0, 'Gagal menghapus data wali');
    }
  }

  Future backPress(BuildContext context) => Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => backPress(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Config.textWhite,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Config.primary,
              )),
          title: Text(
            'Detail Wali Siswa',
            style: TextStyle(color: Config.primary),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.EDIT_WALI, arguments: widget.wali);
                },
                icon: Icon(
                  Icons.edit,
                  color: Config.primary,
                  size: 20,
                )),
            IconButton(
                onPressed: () {
                  _konfirmasi();
                },
                icon: Icon(
                  Icons.delete,
                  color: Config.primary,
                  size: 20,
                ))
          ],
        ),
        body: FutureBuilder(
          // future: WaliProvider().getDetail(widget.wali.id.toString()),
          future: Provider.of<WaliProvider>(context, listen: false).getDetail(widget.wali.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }
            return Consumer<WaliProvider>(builder: (context, data, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: EdgeInsets.all(16), child: Text('Data Wali Siswa')),
                  Config.itemDetail('Nama', data.detailWali.detail.nama ?? '-'),
                  Config.itemDetail('Alamat', data.detailWali.detail.alamat ?? '-'),
                  Config.itemDetail('Status', data.detailWali.detail.status ?? '-'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.all(16), child: Text('Data Akun')),
                    ],
                  ),
                  Config.itemDetail('Username', data.detailWali.detail.username ?? '-'),
                  Config.itemDetail('Phone', data.detailWali.detail.phone ?? '-'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(padding: EdgeInsets.all(16), child: Text('Data Siswa')),
                      InkWell(
                        onTap: () {
                          _addNewSiswa(context);
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
                  for (var i = 0; i < data.detailWali.siswa.length; i++) ...{
                    Config.itemDetail(data.detailWali.siswa[i].nama, Config.formatDateInput(data.detailWali.siswa[i].birthDate.toString())),
                  }
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
