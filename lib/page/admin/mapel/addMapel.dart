import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/loadingButton.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMapel extends StatefulWidget {
  final String id;
  final MapelModel mapel;
  const AddMapel({Key key, this.id, this.mapel}) : super(key: key);

  @override
  _AddMapelState createState() => _AddMapelState();
}

class _AddMapelState extends State<AddMapel> {
  TextEditingController txtMapel = new TextEditingController();
  bool isLoading = false;
  List status = ['Active', 'Inactive'];
  String valStatus;
  MapelModel mapelModel;

  addMapel(context) {
    setState(() {
      isLoading = true;
    });
    Provider.of<MapelProvider>(context, listen: false)
        .tambahMapel(txtMapel.text)
        .then((value) {
      if (value) {
        txtMapel.text = "";
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Config.primary,
            content: Text(
              "Data Mapel Berhasil ditambah",
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        txtMapel.text = "";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Config.alertColor,
            content: Text(
              "Data Mapel Gagal ditambah",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  editMapel(context) {
    Map<String, dynamic> data = {"mapel": txtMapel.text, "status": valStatus};
    widget.mapel.mapel = txtMapel.text;
    widget.mapel.status = valStatus;
    Provider.of<MapelProvider>(context, listen: false)
        .updateMapel(widget.mapel.id.toString(), data);
    Provider.of<MapelProvider>(context, listen: false).mapel = widget.mapel;
    // widget.mapel.mapel =
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Config.primary,
        content: Text(
          "Data Mapel Berhasil ditambah",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != '0') {
      txtMapel.text = widget.mapel.mapel;
    }
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
      body: SingleChildScrollView(
        child: Container(
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Config.borderInput)),
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
              isLoading
                  ? LoadingButton()
                  : ElevatedButton(
                      onPressed: () {
                        // aksi simpan
                        if (widget.id == '0') {
                          addMapel(context);
                        } else {
                          editMapel(context);
                        }
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
