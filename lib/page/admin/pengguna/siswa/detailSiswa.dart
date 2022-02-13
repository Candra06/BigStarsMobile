import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailSiswa extends StatefulWidget {
  final SiswaModel siswa;
  const DetailSiswa({Key key, this.siswa}) : super(key: key);

  @override
  _DetailSiswaState createState() => _DetailSiswaState();
}

class _DetailSiswaState extends State<DetailSiswa> {
  delSiswa() {
    Provider.of<SiswaProvider>(context, listen: false).deleteSiswa(widget.siswa.id.toString()).then((value) {
      print(value);
      if (value) {
        _showSuccesHapus();
      }
    });
  }

  _showSuccesHapus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            // height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/success-delete.json'),
                SizedBox(
                  height: 10,
                ),
                Text('Data has been deleted!'),
              ],
            ),
          ),
          actions: [
            Container(
              width: double.infinity - 30,
              height: 60,
              decoration: BoxDecoration(
                color: Config.boxGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                // textColor: Color(0xFF6200EE),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '3');
                },
                child: Text(
                  'ACCEPT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _showConfirmHapus() {
    showDialog(
        context: context,
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
                      onPressed: () {
                        Navigator.pop(context);
                        // handleHapus();
                        delSiswa();
                        print("ok");
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
        actions: [
          IconButton(
              onPressed: () {
                _showConfirmHapus();
              },
              icon: Icon(
                Icons.delete,
                color: Config.primary,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.EDIT_SISWA, arguments: widget.siswa);
              },
              icon: Icon(
                Icons.edit,
                color: Config.primary,
              ))
        ],
        title: Text(
          'Detail Siswa',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: EdgeInsets.all(16), child: Text('Data Siswa')),
          Config.itemDetail('Nama', widget.siswa.nama),
          Config.itemDetail('Tanggal Lahir', Config.formatDateInput(widget.siswa.birthDate.toString())),
          Config.itemDetail('Alamat', widget.siswa.alamat),
          Config.itemDetail('Wali Siswa', widget.siswa.wali),
          Config.itemDetail('Poin Siswa', widget.siswa.poinSiswa.toString()),
          Config.itemDetail('Status', widget.siswa.status),
          Column(
            children: [
              Container(
                color: Config.textWhite,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kode Referal'),
                    Row(
                      children: [
                        Text(
                          widget.siswa.kodeReferal,
                          style: TextStyle(color: Config.textBlack, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: widget.siswa.kodeReferal));
                              Config.alert(1, 'Kode referal telah disalin');
                            },
                            icon: Icon(Icons.copy))
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 1)
            ],
          )
        ],
      ),
    );
  }
}
