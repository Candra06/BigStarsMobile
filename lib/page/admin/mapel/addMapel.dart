import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:flutter/material.dart';

class AddMapel extends StatefulWidget {
  final String id;
  const AddMapel({Key key, this.id}) : super(key: key);

  @override
  _AddMapelState createState() => _AddMapelState();
}

class _AddMapelState extends State<AddMapel> {
  TextEditingController txtMapel = new TextEditingController();
  List status = ['Active', 'Inactive'];
  String valStatus;
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
          widget.id == '0' ? 'Tambah Mapel' : 'Edit Mapel',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Mapel'),
            formInput(txtMapel, 'Nama Mapel'),
            if (widget.id != '0') ...{
              SizedBox(
                height: 8,
              ),
              Text('Status Mapel'),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 10),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: Text(
                    "Status",
                    style: TextStyle(
                      color: Config.textGrey,
                    ),
                  ),
                  isExpanded: true,
                  value: valStatus,
                  items: status.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valStatus = value;
                    });
                  },
                ),
              ),
            },
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // aksi simpan
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
    );
  }
}
