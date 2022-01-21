import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListKelas.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
import 'package:bigstars_mobile/provider/guru/kelas_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListKelas extends StatefulWidget {
  const ListKelas({Key key}) : super(key: key);

  @override
  _ListKelasState createState() => _ListKelasState();
}

class _ListKelasState extends State<ListKelas> {
  Map<String, dynamic> data;
  List<KelasModel> dataKelas;
  bool load = true;

  TextEditingController txtNamaSiswa = new TextEditingController();
  TextEditingController txtNamaGuru = new TextEditingController();
  List<String> statusKelas = ['Active', 'Inactive'];
  String status;

  void _filter(BuildContext context, String id, Map<String, dynamic> data) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Container(
            // padding: EdgeInsets.all(16),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    formInputType(
                        txtNamaSiswa, 'Nama Siswa', TextInputType.text),
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
                            print(status);
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              filter();
                            },
                            child: Text(
                              'Terapkan',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Config.textWhite),
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
        });
  }

  void filter() async {
    setState(() {
      load = true;
    });
    List data = [txtNamaSiswa.text, txtNamaGuru.text, status];
    dataKelas = await Provider.of<KelasProvider>(context, listen: false)
        .getFilterKelas(data.join('/'));
    setState(() {
      load = false;
    });
  }

  void getData() async {
    setState(() {
      load = true;
    });
    dataKelas =
        await Provider.of<KelasProvider>(context, listen: false).getKelas();
    setState(() {
      load = false;
    });
  }

  void filterData() async {}

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        automaticallyImplyLeading: false,
        title: Text(
          "Kelas",
          style: TextStyle(color: Config.primary),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _filter(context, '1', data);
              },
              icon: Icon(
                FontAwesomeIcons.filter,
                size: 20,
                color: Config.primary,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.ADD_KELAS);
              },
              icon: Icon(
                FontAwesomeIcons.plus,
                size: 20,
                color: Config.primary,
              ))
        ],
      ),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: dataKelas.length,
                itemBuilder: (BuildContext bc, int i) {
                  return dataKelas.isNotEmpty
                      ? ItemKelas(
                          data: dataKelas[i],
                        )
                      : Center(
                          child: Text('Belum ada data kelas'),
                        );
                },
              ),
            ),
      // body: Container(
      //   margin: EdgeInsets.all(16),
      //   child: FutureBuilder(
      //       future:
      //           Provider.of<KelasProvider>(context, listen: false).getKelas(),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         }
      //         return Consumer<KelasProvider>(
      //           builder: (context, data, _) => ListView.builder(
      //               itemCount: data.allKelas.length,
      //               itemBuilder: (BuildContext bc, int i) {
      //                 return snapshot.hasData
      //                     ? ItemKelas(
      //                         data: data.allKelas[i],
      //                       )
      //                     : Center(
      //                         child: Text('Belum ada data kelas'),
      //                       );
      //               }),
      //         );
      //       }),
      // ),
    );
  }
}
