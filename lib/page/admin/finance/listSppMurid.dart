import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListSPP.dart';
import 'package:bigstars_mobile/page/modal/modalFilterSPP.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ListSppMurid extends StatefulWidget {
  const ListSppMurid({Key key}) : super(key: key);

  @override
  _ListSppMuridState createState() => _ListSppMuridState();
}

class _ListSppMuridState extends State<ListSppMurid> {
<<<<<<< HEAD
  List<String> filter = [];
  String _filter = '';
  void modalFilter(BuildContext context) {
    void filtered(String nama, bulan, tahun) async {
      if (nama != '') {
        filter.removeWhere((element) => element.startsWith('nama'));
        filter.add('nama=' + nama);
      }
      if (bulan != '') {
        filter.removeWhere((element) => element.startsWith('bulan'));
        filter.add('bulan=' + bulan);
      }
      if (tahun != '') {
        filter.removeWhere((element) => element.startsWith('tahun'));
        filter.add('tahun=' + tahun);
      }
      setState(() {
        _filter = filter.join('&').toString();
      });
    }

=======
  DateTime _dateTime;
  String valBulan;
  TextEditingController txtNamaSiswa = new TextEditingController();
  TextEditingController txtBulan = new TextEditingController();
  List<String> statusPembayaran = ['Lunas', 'Belum Lunas'];
  String status;
  void _filter(BuildContext context, String id) {
>>>>>>> abeb55e3b09df5f926598e649f66a151539a256c
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
<<<<<<< HEAD
          return ModalFilterSPP(
            // id: id,
            onsubmit: filtered,
=======
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
                            Text('Filter SPP',
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
                    Text('Nama Siswa',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    formInputType(
                        txtNamaSiswa, 'Nama Siswa', TextInputType.text),
                    SizedBox(height: 8),
                    Text('Bulan',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 10),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Config.borderInput)),
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
                                        showDatePicker(
                                                context: context,
                                                initialDate: _dateTime == null
                                                    ? DateTime.now()
                                                    : _dateTime,
                                                firstDate: DateTime(2020),
                                                lastDate: DateTime.now())
                                            .then((date) {
                                          if (date != null) {
                                            // setState(() {
                                            _dateTime = date;
                                            txtBulan.text =
                                                Config.formatDateInput(
                                                    date.toString());
                                            var tgl =
                                                _dateTime.toString().split(' ');
                                            valBulan = tgl[0].toString();
                                            // });
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
                    Text('Status Pembayaran'),
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
                        items: statusPembayaran.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          status = value;
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
                              setState(() {
                                isFilter = true;
                              });
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
>>>>>>> abeb55e3b09df5f926598e649f66a151539a256c
          );
        });
  }

  bool isLoading = false;
<<<<<<< HEAD

=======
  bool isFilter = false;
>>>>>>> abeb55e3b09df5f926598e649f66a151539a256c
  void _showSuccesAdd() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              // height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/success-delete.json'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Generated Successfull!'),
                ],
              ),
            ),
            actions: [
              Container(
                width: double.infinity - 30,
                height: 60,
                decoration: BoxDecoration(
                  color: Config.boxGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  // textColor: Color(0xFF6200EE),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ACCEPT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void generateSpp() async {
    setState(() {
      isLoading = true;
    });

    await Provider.of<FinanceProvider>(context, listen: false).generateSpp().then((value) {
      if (value) {
        _showSuccesAdd();
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  function() {
    if (isFilter) {
      if (txtNamaSiswa.text.isEmpty ||
          txtBulan.text.isEmpty ||
          status == null) {
        return Provider.of<FinanceProvider>(context, listen: false).getSpp();
      } else {
        List data = [txtNamaSiswa.text, valBulan, status];
        // txtNamaSiswa.text = "";
        // txtBulan.text = "";
        // status = null;
        // "Siswa/2021-11-24/Lunas"
        print(data.join("/"));
        return Provider.of<FinanceProvider>(context, listen: false)
            .filterSpp(data.join("/"));
      }
    }
    return Provider.of<FinanceProvider>(context, listen: false).getSpp();
  }

  @override
  Widget build(BuildContext context) {
    Widget generateSppbtn() {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: ElevatedButton(
          onPressed: () {
            generateSpp();
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 30),
            primary: Config.primary,
            onPrimary: Config.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            "Generate SPP",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }

    Widget loadGeneratesppbtn() {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 30),
            primary: Config.primary,
            onPrimary: Config.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Loading",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Config.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
<<<<<<< HEAD
              filter = [];
              _filter = '';
              // Navigator.pop(context);
              modalFilter(context);
=======
              _filter(context, 'id');
>>>>>>> abeb55e3b09df5f926598e649f66a151539a256c
            },
            icon: Icon(
              FontAwesomeIcons.filter,
              size: 20,
              color: Config.primary,
            ),
          ),
        ],
        backgroundColor: Config.textWhite,
        title: Text(
          "SPP Murid",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        // child: ListView.builder(
        //     itemCount: 3,
        //     itemBuilder: (BuildContext bc, int i) {
        //       return ItemListSPP();
        //     }),
        child: Column(
          children: [
            isLoading ? loadGeneratesppbtn() : generateSppbtn(),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
<<<<<<< HEAD
                future: Provider.of<FinanceProvider>(context, listen: false).getSpp(_filter),
=======
                future: function(),
>>>>>>> abeb55e3b09df5f926598e649f66a151539a256c
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<FinanceProvider>(
                    builder: (context, data, _) {
                      return ListView.builder(
                        itemCount: data.ListSppModel.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext bc, int i) {
                          return ItemListSPP(
                            data: data.ListSppModel[i],
                          );
                        },
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
