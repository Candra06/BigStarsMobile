import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:flutter/material.dart';

class ModalFilterKelas extends StatefulWidget {
  final String idWali;
  final void Function(String, String, String) onsubmit;
  const ModalFilterKelas({Key key, this.idWali, this.onsubmit})
      : super(key: key);

  @override
  _ModalFilterKelasState createState() => _ModalFilterKelasState();
}

class _ModalFilterKelasState extends State<ModalFilterKelas> {
  TextEditingController txtNamaSiswa = new TextEditingController();
  TextEditingController txtNamaGuru = new TextEditingController();
  List<String> statusKelas = ['Active', 'Inactive'];
  String status;

  @override
  void initState() {
    txtNamaGuru.text = '';
    txtNamaSiswa.text = '';
    status = null;
    super.initState();
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
                      Text(
                        'Filter Kelas',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
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
              //Jika role wali di hide inputan nama siswa
              Text('Nama Siswa',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              formInputType(txtNamaSiswa, 'Nama Siswa', TextInputType.text),
              SizedBox(height: 8),
              //Jika role guru di hide inputan nama guru
              Text('Nama Guru',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              formInputType(txtNamaGuru, 'Nama Guru', TextInputType.text),
              SizedBox(height: 8),
              Text('Status Kelas'),
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
                    "Pilih Status",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: status,
                  items: statusKelas.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                  },
                ),
              ),
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
                          String siswa = '', guru = '';
                          if (txtNamaSiswa.text.isNotEmpty) {
                            siswa = txtNamaSiswa.text.toString();
                          } else {
                            siswa = '';
                          }
                          if (txtNamaGuru.text.isNotEmpty) {
                            guru = txtNamaGuru.text.toString();
                          } else {
                            guru = '';
                          }
                          if (status == null) {
                            status = '';
                          } else {
                            status = status;
                          }
                          // txtNamaGuru.text = '';
                          // txtNamaSiswa.text = '';
                          // status = null;
                          Navigator.pop(context);
                          widget.onsubmit(guru, siswa, status);
                        },
                        child: Text('Terapkan',
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
