import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:flutter/material.dart';

class ModalFilterSPP extends StatefulWidget {
  final String idWali;
  const ModalFilterSPP({Key key, this.idWali}) : super(key: key);

  @override
  _ModalFilterSPPState createState() => _ModalFilterSPPState();
}

class _ModalFilterSPPState extends State<ModalFilterSPP> {
  DateTime _dateTime;
  String valBulan;
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
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextField(
                          readOnly: true,
                          controller: txtBulan,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Config.textGrey,
                                ),
                                onPressed: () {
                                  showDatePicker(context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime, firstDate: DateTime(2020), lastDate: DateTime.now()).then((date) {
                                    if (date != null) {
                                      setState(() {
                                        _dateTime = date;
                                        txtBulan.text = Config.formatDateInput(date.toString());
                                        var tgl = _dateTime.toString().split(' ');
                                        valBulan = tgl[0].toString();
                                      });
                                    }
                                  });
                                }),
                            border: InputBorder.none,
                            hintText: 'Bulan',
                            hintStyle: TextStyle(color: Config.textGrey),
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.white,
                    )
                  ],
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
