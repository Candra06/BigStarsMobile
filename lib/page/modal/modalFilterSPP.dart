import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:flutter/material.dart';

class ModalFilterSPP extends StatefulWidget {
  final String idWali;

  final void Function(String, String, String) onsubmit;
  const ModalFilterSPP({Key key, this.idWali, this.onsubmit}) : super(key: key);

  @override
  _ModalFilterSPPState createState() => _ModalFilterSPPState();
}

class _ModalFilterSPPState extends State<ModalFilterSPP> {
  DateTime _dateTime;
  List<String> _tahun = ['2021', '2022', '2023', '2024', '2025'];
  List<String> _bulan = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
  String valBulan, fBulan = '';
  String valTahun, fTahun = '';
  TextEditingController txtNamaSiswa = new TextEditingController();
  TextEditingController txtBulan = new TextEditingController();

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
                    children: [Text('Filter SPP', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))],
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
              Text('Nama Siswa',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              formInputType(txtNamaSiswa, 'Nama Siswa', TextInputType.text),
              SizedBox(height: 8),
              Text('Bulan',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 10),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: Text(
                    "Pilih Bulan",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: valBulan,
                  items: _bulan.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      int index = _bulan.indexOf(value);
                      int bulan = index + 1;
                      valBulan = value;
                      fBulan = bulan.toString();
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              Text('Tahun',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 10),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: Text(
                    "Pilih Tahun",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: valTahun,
                  items: _tahun.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valTahun = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
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
                          String siswa = '', tmpBulan = '';
                          if (txtNamaSiswa.text.isNotEmpty) {
                            siswa = txtNamaSiswa.text.toString();
                          } else {
                            siswa = '';
                          }
                          if (valBulan != null) {
                            tmpBulan = fBulan;
                          } else {
                            tmpBulan = '';
                          }
                          if (valTahun == null) {
                            valTahun = '';
                          } else {
                            valTahun = valTahun;
                          }
                          widget.onsubmit(siswa, tmpBulan, valTahun);
                          Navigator.pop(context);
                        },
                        child: Text('Terapkan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Config.textWhite))),
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
