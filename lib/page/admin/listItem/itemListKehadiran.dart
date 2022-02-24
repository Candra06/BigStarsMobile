import 'dart:io';
import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranGuru.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoder/geocoder.dart';

class ItemListKehadiran extends StatefulWidget {
  final ListKehadiran data;
  final KehadiranModel kehadiran;
  final String role;
  const ItemListKehadiran({Key key, this.data, this.kehadiran, this.role}) : super(key: key);

  @override
  _ItemListKehadiranState createState() => _ItemListKehadiranState();
}

class _ItemListKehadiranState extends State<ItemListKehadiran> {
  void _updateKehadiran(BuildContext context, String id, ListKehadiran data) {
    void onSubmit(status) {
      if (status) {
        // setState(() {
        //   // Provider.of<KelasProvider>(context, listen: false).getKehadiran(widget.data.id.toString());
        // });
      }
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalTambahKehadiranGuru(
            id: id,
            tipe: 'Update',
            data: data,
            onSumbit: onSubmit,
          );
        });
  }

  void _showConfirmHapus(int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 300,
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
                    child: Text('Apakah anda yakin ingin menghapus kehadiran ?', textAlign: TextAlign.center),
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
                        'Batal',
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
                        // handleHapus();
                        await Provider.of<KelasProvider>(context, listen: false).deleteKehadiran(widget.data.id, widget.data.idKelas).then((value) {
                          print(value);
                          if (value == true) {
                            Config.alert(1, 'Berhasil menghapus kehadiran');
                            Navigator.pop(context);
                            Navigator.pop(context);
                            return true;
                          } else {
                            return false;
                          }
                        });
                      },
                      child: Text(
                        'Hapus',
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

  String alamat = '-';

  bool isLoading = false;
  Future<File> downloadFile(String name) async {
    String appDocDirectory = (await getApplicationDocumentsDirectory()).path;
    final file = File(appDocDirectory + '/$name');
    try {
      // final reponse = await Dio(),
    } catch (e) {
      print(e);
    }
  }

  Future _download(String url) async {
    setState(() {
      isLoading = true;
    });
    // String dir =
    String fileName = url.substring(url.lastIndexOf("/") + 1);
    // String dir = await getDirectoryPath();
    HttpClient httpClient = new HttpClient();
    File file;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        // var filePath = '$dir/$fileName';
        // file = File(filePath);
        await file.writeAsBytes(bytes);
        print("berhasil");
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  void getUserLocation(String latitude, String longitude) async {
    //call this async method from whereever you need

    String error;

    var coordinates = new Coordinates(double.parse(latitude), double.parse(longitude));

    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    if (mounted) {
      setState(() {
        alamat =
            ' ${first.locality.toString()}, ${first.adminArea.toString()},${first.subLocality.toString()}, ${first.subAdminArea.toString()},${first.addressLine.toString()}, ${first.featureName.toString()}';
      });
    }
    // setState(() {

    // });

    // print(alamat);
    // return ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}';
  }

  void aksi() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: new Wrap(
            children: [
              if (widget.data.fileMateri != '-') ...{
                new ListTile(
                  leading: new Icon(Icons.download),
                  title: new Text('Download Materi'),
                  onTap: () async {
                    String url = EndPoint.server + widget.data.fileMateri;
                    //       print(url);
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw "Could not launch $url";
                    }
                  },
                ),
              },
              if (widget.role == 'Admin') ...{
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text('Hapus Kehadiran'),
                  onTap: () {
                    _showConfirmHapus(widget.data.id);

                    //   // print(param['id'].toString())
                    //   Navigator.of(bc).pop();
                    //   _followUp(param.id.toString(), param.statusProspek.toString());
                  },
                ),
              },
              if (widget.data.status == 'Waiting') ...{
                new ListTile(
                  leading: new Icon(Icons.update),
                  title: new Text('Perbarui Kehadiran'),
                  onTap: () {
                    _updateKehadiran(context, widget.data.id.toString(), widget.data);
                  },
                ),
              }
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getUserLocation(widget.data.latitude, widget.data.longitude);
    super.initState();
  }

  @override
  void dispose() {
    getUserLocation(widget.data.latitude, widget.data.longitude);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingText() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Unduh Materi",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 4),
      color: Config.textWhite,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data.materi,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  widget.data.status,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Guru'),
                Text(
                  widget.data.nama,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tipe Pengajar',
                ),
                Text(
                  widget.data.tipe,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Jurnal',
            ),
            Text(
              widget.data.jurnal,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [],
            // ),

            SizedBox(
              height: 8,
            ),
            Text(
              'Lokasi Absensi',
            ),
            Text(
              alamat,
              maxLines: 3,
            ),
            SizedBox(
              height: 9,
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Config.formatDateTime(widget.data.createdAt.toString()) + ' ' + Config.formatDateTimeJam(widget.data.createdAt.toString()),
                  // widget.data.createdAt.toString()
                ),

                IconButton(
                    onPressed: () {
                      aksi();
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Config.textGrey,
                    ))

                // Container(
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                //   child: Text(
                //     'Hapus',
                //     style: TextStyle(color: Config.textWhite),
                //   ),
                // )
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // if (widget.data.fileMateri != '-') ...{
            //   ElevatedButton(
            //     onPressed: () async {
            //       print(widget.data.fileMateri);
            //       String url = EndPoint.server + widget.data.fileMateri;
            //       print(url);
            //       if (await canLaunch(url)) {
            //         await launch(url);
            //       } else {
            //         throw "Could not launch $url";
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //       fixedSize: Size(MediaQuery.of(context).size.width, 30),
            //       primary: Config.primary,
            //       onPrimary: Config.textWhite,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8.0),
            //       ),
            //     ),
            //     child: isLoading
            //         ? loadingText()
            //         : Text(
            //             "Unduh Materi",
            //             style: TextStyle(color: Colors.white, fontSize: 14),
            //           ),
            //   ),
            // },
            // jika belum done / status waiting ketika sharing kelas button update absensi muncul
            // if (widget.data.status == 'Waiting') ...{
            //   ElevatedButton(
            //     onPressed: () {
            //       _updateKehadiran(context, widget.data.id.toString(), widget.data);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       fixedSize: Size(MediaQuery.of(context).size.width, 30),
            //       primary: Config.boxGreen,
            //       onPrimary: Config.textWhite,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8.0),
            //       ),
            //     ),
            //     child: Text(
            //       "Perbarui Kehadiran",
            //       style: TextStyle(color: Colors.white, fontSize: 14),
            //     ),
            //   )
            // }
          ],
        ),
      ),
    );
  }
}
