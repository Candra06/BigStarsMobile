import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:flutter/material.dart';

class ModalSharingKelas extends StatefulWidget {
  final String id;
  final List<GuruModel> gurus;
  const ModalSharingKelas({Key key, this.id, this.gurus}) : super(key: key);

  @override
  _ModalSharingKelasState createState() => _ModalSharingKelasState();
}

class _ModalSharingKelasState extends State<ModalSharingKelas> {
  String tglKelas, idGuru, namaGuru;
  List listGuru = [
    {"id": 1, "nama": "heri"}
  ];

  getData() {
    // print(widget.gurus.length);
    int jumlahGuru = widget.gurus.length;
    // for (var i = 0; i < jumlahGuru; i++) {
    //   // print(i);
    //   listGuru.add({
    //     "id": widget.gurus[i].id,
    //     "nama": widget.gurus[i].nama,
    //   });
    // }
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
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
          color: Config.background,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
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
                    children: [
                      Text('Sharing Kelas',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))
                    ],
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Config.borderInput)),
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: Text(
                    "Pilih Guru",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: namaGuru,
                  items: listGuru.map((value) {
                    return DropdownMenuItem(
                      child: Text(value["nama"]),
                      value: value["id"],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      idGuru = value;
                      print(value);
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
                    decoration: BoxDecoration(
                        color: Config.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('SIMPAN',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Config.textWhite))),
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
