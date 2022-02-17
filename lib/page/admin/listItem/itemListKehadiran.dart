import 'dart:io';
import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranGuru.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoder/geocoder.dart';

class ItemListKehadiran extends StatefulWidget {
  final KehadiranModel data;
  const ItemListKehadiran({Key key, this.data}) : super(key: key);

  @override
  _ItemListKehadiranState createState() => _ItemListKehadiranState();
}

class _ItemListKehadiranState extends State<ItemListKehadiran> {
  void _updateKehadiran(BuildContext context, String id, KehadiranModel data) {
    void onSubmit(status) {
      if (status) {
        setState(() {
          // Provider.of<KelasProvider>(context, listen: false).getKehadiran(widget.data.id.toString());
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
          return ModalTambahKehadiranGuru(
            id: id,
            tipe: 'Update',
            data: data,
            onSumbit: onSubmit,
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
                  widget.data.nama,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  widget.data.tipe,
                  style: TextStyle(fontWeight: FontWeight.w900),
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
                  widget.data.materi,
                ),
                Text(
                  widget.data.status,
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
              maxLines: 3,
            ),
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
            SizedBox(height: 8),
            Text(
              Config.formatDateTime(widget.data.createdAt.toString()) + ' ' + Config.formatDateTimeJam(widget.data.createdAt.toString()),
              // widget.data.createdAt.toString()
            ),
            SizedBox(
              height: 20,
            ),
            if (widget.data.fileMateri != '-') ...{
              ElevatedButton(
                onPressed: () async {
                  print(widget.data.fileMateri);
                  String url = EndPoint.server + widget.data.fileMateri;
                  print(url);
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw "Could not launch $url";
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 30),
                  primary: Config.primary,
                  onPrimary: Config.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: isLoading
                    ? loadingText()
                    : Text(
                        "Unduh Materi",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
              ),
            },
            // jika belum done / status waiting ketika sharing kelas button update absensi muncul
            if (widget.data.status == 'Waiting') ...{
              ElevatedButton(
                onPressed: () {
                  _updateKehadiran(context, widget.data.id.toString(), widget.data);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 30),
                  primary: Config.boxGreen,
                  onPrimary: Config.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Perbarui Kehadiran",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
