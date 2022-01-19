import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKehadiran.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranAdmin.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KehadiranKelas extends StatefulWidget {
  final KelasModel kelas;
  const KehadiranKelas({Key key, this.kelas}) : super(key: key);

  @override
  _KehadiranKelasState createState() => _KehadiranKelasState();
}

class _KehadiranKelasState extends State<KehadiranKelas> {
  bool load = false;
  void _addNewKehadiran(BuildContext context, String id) {
    void onSubmit(status) {
      if (status) {
        setState(() {
          Provider.of<KelasProvider>(context, listen: false).getKehadiran(widget.kelas.id.toString());
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
          return ModalTambahKehadiran(
            id: id,
            onsubmit: onSubmit,
          );
        });
  }

  void getData() async {
    List<KehadiranModel> data = await Provider.of<KelasProvider>(context, listen: false).getKehadiran('1');
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primary,
          onPressed: () {
            _addNewKehadiran(context, widget.kelas.id.toString());
          },
          child: Icon(
            Icons.add,
            color: Config.textWhite,
          )),
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : Container(
              margin: EdgeInsets.only(
                top: 16,
              ),
              child: FutureBuilder(
                future: Provider.of<KelasProvider>(context, listen: false).getKehadiran(widget.kelas.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<KelasProvider>(builder: (context, data, _) {
                    return ListView.builder(
                        itemCount: data.listKehadiranModel.length,
                        itemBuilder: (BuildContext context, int i) {
                          return ItemListKehadiran(
                            data: data.listKehadiranModel[i],
                          );
                        });
                  });
                },
              ),
            ),
    );
  }
}
