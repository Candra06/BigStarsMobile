import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ModalSharingKelas extends StatefulWidget {
  final String id;
  final List gurus;
  final void Function() berhasil;
  const ModalSharingKelas({Key key, this.id, this.gurus, this.berhasil}) : super(key: key);

  @override
  _ModalSharingKelasState createState() => _ModalSharingKelasState();
}

class _ModalSharingKelasState extends State<ModalSharingKelas> {
  String tglKelas, idGuru, namaGuru;
  List listGuru = [];
  bool isLoading = false;
  Position currentPosition;

  getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true).then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void addSharing() async {
    var data = {"id_guru": idGuru, 'latitude': currentPosition.latitude.toString(), 'longitude': currentPosition.longitude.toString()};
    Map<String, dynamic> status = await Provider.of<KelasProvider>(context, listen: false).addSharing(widget.id, data);
    if (status['status'] == true) {
      widget.berhasil();
    } else {
      Config.alert(0, status['message']);
    }
  }

  getData() {
    setState(() {
      // listGuru = widget.gurus;
    });
    getCurrentLocation();
    for (var i = 0; i < widget.gurus.length; i++) {
      listGuru.add(widget.gurus[i]);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(color: Config.background, borderRadius: new BorderRadius.only(topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [Text('Sharing Kelas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              Divider(
                height: 22,
              ),
              SizedBox(height: 8),
              Text('Guru'),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 10),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: Text(
                    "Pilih Guru",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: idGuru,
                  items: listGuru.map((value) {
                    return DropdownMenuItem(
                      child: Text(value["nama"]),
                      value: value["id"],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      idGuru = value;
                      print(idGuru);
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 4, top: 8),
                    decoration: BoxDecoration(color: Config.primary, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);

                        addSharing();
                      },
                      child: Text(
                        'SIMPAN',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Config.textWhite,
                        ),
                      ),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
