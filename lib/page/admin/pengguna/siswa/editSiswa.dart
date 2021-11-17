import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:flutter/material.dart';

class EditSiswa extends StatefulWidget {
  final String id;
  const EditSiswa({Key key, this.id}) : super(key: key);

  @override
  _EditSiswaState createState() => _EditSiswaState();
}

class _EditSiswaState extends State<EditSiswa> {
  DateTime _dateTime;
  String tglLahir;
  bool obsecured = true;
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtTglLahir = new TextEditingController();
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
          'Edit Siswa',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Siswa'),
              formInput(txtNama, 'Nama Siswa'),
              SizedBox(
                height: 10,
              ),
              Text('Tanggal Lahir'),
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
                          controller: txtTglLahir,
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
                                        txtTglLahir.text = Config.formatDateInput(date.toString());
                                        var tgl = _dateTime.toString().split(' ');
                                        tglLahir = tgl[0].toString();
                                      });
                                    }
                                  });
                                }),
                            border: InputBorder.none,
                            hintText: 'Tanggal Lahir',
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // submit proses
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  primary: Config.primary,
                  onPrimary: Config.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
