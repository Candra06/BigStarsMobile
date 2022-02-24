import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
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
          "Invoice SPP",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: load
          ? LinearProgressIndicator()
          : Container(
              color: Config.background,
              // margin: EdgeInsets.all(16),
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Config.primary,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/logoWhite.png',
                                  height: 125,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Nomor Invoice',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Config.textWhite),
                                      ),
                                      Text(
                                        detailSPPModel.noInvoice,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Config.textWhite),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      // padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  detailSPPModel.nama,
                                                  style: TextStyle(color: Config.primary, fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(color: detailSPPModel.status == 'Lunas' ? Colors.green : Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                                                  child: Text(
                                                    // 'Lunas',
                                                    detailSPPModel.status,
                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                  ),
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
                                                  Config.formatBulan(detailSPPModel.tagihanBulan.toString()),
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
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Keterangan',
                                                ),
                                                Text(
                                                  detailSPPModel.keterangan ?? '-',
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
                                                Container(),
                                                Text(
                                                  'Total Tagihan',
                                                ),
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
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(
                                      'Pembayaran via transfer melalui nomor rekening',
                                      style: TextStyle(color: Config.textWhite, fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Container(),
                                  RichText(
                                    textAlign: TextAlign.end,
                                    text: TextSpan(
                                      text: 'BCA 200843566 ',
                                      style: TextStyle(color: Config.textWhite, fontSize: 18, fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(text: 'a/n \n', style: TextStyle(fontSize: 16)),
                                        TextSpan(text: 'Dewi Pancawati Ningsih', style: TextStyle(color: Config.textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Riwayat Kehadiran',
                                          style: TextStyle(color: Config.textGrey),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, Routes.HISTORY_KEHADIRAN_SPP, arguments: detailSPPModel.historiKehadiran);
                                          },
                                          child: Text(
                                            'Lihat Semua',
                                            style: TextStyle(color: Config.textGrey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  SizedBox(
                                    // height: MediaQuery.of(context).size.height * 0.35,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: detailSPPModel.historiKehadiran.length > 3 ? 3 : detailSPPModel.historiKehadiran.length,
                                        itemBuilder: (BuildContext bc, int i) {
                                          return Container(
                                            color: Config.textWhite,
                                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                                                Text(
                                                    Config.formatDateTime(detailSPPModel.historiKehadiran[i].createdAt) + ' ' + Config.formatDateTimeJam(detailSPPModel.historiKehadiran[i].createdAt)),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                  if (role == 'Admin' && detailSPPModel.status != 'Lunas') ...{
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          _konfirmasi();
                        },
                        child: Container(
                          color: Config.primary,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Text(
                            "KONFIRMASI",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  },
                ],
              ),
            ),
    );
  }
}
