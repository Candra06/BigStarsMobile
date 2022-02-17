import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/loadingButton.dart';
import 'package:bigstars_mobile/provider/wali_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalTambahSiswa extends StatefulWidget {
  final String idWali;
  final void Function(bool) respon;
  const ModalTambahSiswa({Key key, this.idWali, this.respon}) : super(key: key);

  @override
  _ModalTambahSiswaState createState() => _ModalTambahSiswaState();
}

class _ModalTambahSiswaState extends State<ModalTambahSiswa> {
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtTglLahir = new TextEditingController();
  DateTime _dateTime;
  String tglLahir;
  bool isloading = false;

  dataResquest() async {
    setState(() {
      isloading = true;
    });
    Map<String, dynamic> data = {'nama': txtNama.text, 'birth_date': tglLahir, 'id_wali': widget.idWali};
    // print(data);

    bool respon = await Provider.of<WaliProvider>(context, listen: false).addSiswaBywali(widget.idWali, data);
    if (respon == true) {
      Config.alert(1, 'Berhasil menambah siswa');
      widget.respon(true);
      // setState(() {
      //   isloading = false;

      // });
    } else {
      Config.alert(0, 'Gagal menambah siswa');
      setState(() {
        isloading = false;
        // Navigator.pop(context);
      });
    }
    // print()
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
                    children: [Text('Tambah Siswa', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))],
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
              Text('Nama',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              formInputType(txtNama, 'Nama', TextInputType.text),
              SizedBox(height: 8),
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
                                  showDatePicker(context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime, firstDate: DateTime(2000), lastDate: DateTime.now()).then((date) {
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
                    child: isloading
                        ? LoadingButton()
                        : TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              dataResquest();
                            },
                            child: Text('SIMPAN', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Config.textWhite))),
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
