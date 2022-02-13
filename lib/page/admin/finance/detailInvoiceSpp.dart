import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/DetailSpp_model.dart';
import 'package:bigstars_mobile/model/spp_model.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InvoiceSPP extends StatefulWidget {
  final String id;
  const InvoiceSPP({Key key, this.id}) : super(key: key);

  @override
  _InvoiceSPPState createState() => _InvoiceSPPState();
}

class _InvoiceSPPState extends State<InvoiceSPP> {
  DetailSPPModel detailSPPModel;
  bool load = true;

  String role;

  void _showSucces() {
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
                  Text('Terkonfirmasi!'),
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
                    getData();
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

  void _konfirmasi() async {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Apakah anda yakin?'),
        content: new Text('Ingin mengkonfirmasi pembayaran SPP.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Tidak'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              konfirmasi();
            },
            child: new Text('Iya'),
          ),
        ],
      ),
    );
  }

  void konfirmasi() async {
    bool status = await Provider.of<FinanceProvider>(context, listen: false).konfirmasiSPP(widget.id);
    if (status) {
      _showSucces();
    }
  }

  void getData() async {
    String tmpRole = await Pref.getRole();
    setState(() {
      role = tmpRole;
      load = true;
    });
    detailSPPModel = await Provider.of<FinanceProvider>(context, listen: false).detailSpp(widget.id);

    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Config.textWhite,
        title: Text(
          "Inovice SPP",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: load
          ? LinearProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        FontAwesomeIcons.fileInvoiceDollar,
                        size: 100,
                        color: Config.primary,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nomor Invoice',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  detailSPPModel.noInvoice,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Config.primary),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tagihan Bulan',
                                  style: TextStyle(),
                                ),
                                Text(
                                  'Oktober 2021',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Siswa',
                                  style: TextStyle(),
                                ),
                                Text(
                                  detailSPPModel.nama,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jumlah Pertemuan',
                                ),
                                Text(
                                  detailSPPModel.totalPertemuan.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status',
                                ),
                                Text(
                                  // 'Lunas',
                                  detailSPPModel.status,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.green,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Tagihan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container()
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Text(
                                  Config.formatRupiah(int.parse(detailSPPModel.jumlah)),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (role != 'Walimurid') ...{
                            Container(
                              margin: EdgeInsets.only(left: 8, right: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  _konfirmasi();
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
                                  "Konfirmasi Tagihan",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          },
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Riwayat Kehadiran'),
                    SizedBox(height: 20),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: detailSPPModel.historiKehadiran.length,
                        itemBuilder: (BuildContext bc, int i) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(detailSPPModel.historiKehadiran[i].mapel),
                                      Text(detailSPPModel.historiKehadiran[i].nama),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(detailSPPModel.historiKehadiran[i].materi),
                                      Text(Config.formatRupiah(int.parse(detailSPPModel.historiKehadiran[i].spp))),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(Config.formatDateTime(detailSPPModel.historiKehadiran[i].createdAt) + ' ' + Config.formatDateTimeJam(detailSPPModel.historiKehadiran[i].createdAt))
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
