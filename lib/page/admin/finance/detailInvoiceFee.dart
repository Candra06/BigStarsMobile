import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/DetailFee_model.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InvoiceFee extends StatefulWidget {
  final String fee;
  const InvoiceFee({Key key, this.fee}) : super(key: key);

  @override
  _InvoiceFeeState createState() => _InvoiceFeeState();
}

class _InvoiceFeeState extends State<InvoiceFee> {
  String role = "";
  DetailFeeModel detailFee;
  // DetailFeeModel detailFee;
  bool load = true;
  void _showSucces() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/success.json'),
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
        content: new Text('Ingin mengkonfirmasi pembayaran Fee Guru.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Tidak'),
          ),
          new FlatButton(
            onPressed: () {
              konfirmasi();
              Navigator.of(context).pop(false);
            },
            child: new Text('Iya'),
          ),
        ],
      ),
    );
  }

  void konfirmasi() async {
    bool status = await Provider.of<FinanceProvider>(context, listen: false).konfirmasiFee(widget.fee);
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
    detailFee = await Provider.of<FinanceProvider>(context, listen: false).detailFee(widget.fee);

    setState(() {
      print(detailFee.noInvoice);
      load = false;
    });
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          "Invoice Pembayaran Fee",
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
                                        detailFee.noInvoice ?? '-',
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
                                                Flexible(
                                                  child: Text(
                                                    detailFee.nama,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(color: Config.primary, fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(color: detailFee.status == 'Lunas' ? Colors.green : Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                                                  child: Text(
                                                    // 'Lunas',
                                                    detailFee.status,
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
                                                  Config.formatBulan(detailFee.tagihanBulan.toString()),
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
                                                  detailFee.totalPertemuan.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Column(
                                          //     crossAxisAlignment: CrossAxisAlignment.start,
                                          //     children: [
                                          //       Text(
                                          //         'Keterangan',
                                          //       ),
                                          //       Text(
                                          //         detailFee.keterangan ?? '-',
                                          //         style: TextStyle(
                                          //           fontWeight: FontWeight.bold,
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
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
                                                  Config.formatRupiah(int.parse(detailFee.jumlah.toString())),
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
                                            Navigator.pushNamed(context, Routes.HISTORY_KEHADIRAN_FEE, arguments: detailFee.historiKehadiranGuru);
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
                                        itemCount: detailFee.historiKehadiranGuru.length > 3 ? 3 : detailFee.historiKehadiranGuru.length,
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
                                                    Text(detailFee.historiKehadiranGuru[i].mapel),
                                                    Text(detailFee.historiKehadiranGuru[i].nama),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        detailFee.historiKehadiranGuru[i].materi,
                                                        maxLines: 1,
                                                        softWrap: true,
                                                        overflow: TextOverflow.clip,
                                                      ),
                                                    ),
                                                    Text(Config.formatRupiah(detailFee.historiKehadiranGuru[i].feePengajar)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(Config.formatDateTime(detailFee.historiKehadiranGuru[i].createdAt) + ' ' + Config.formatDateTimeJam(detailFee.historiKehadiranGuru[i].createdAt)),
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
                  if (role == 'Admin' && detailFee.status != 'Lunas') ...{
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
