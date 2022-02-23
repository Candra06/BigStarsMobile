import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InvoiceFee extends StatefulWidget {
  final FeeGuruModel fee;
  const InvoiceFee({Key key, this.fee}) : super(key: key);

  @override
  _InvoiceFeeState createState() => _InvoiceFeeState();
}

class _InvoiceFeeState extends State<InvoiceFee> {
  String role = "";
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
    bool status = await Provider.of<FinanceProvider>(context, listen: false).konfirmasiFee(widget.fee.id.toString());
    if (status) {
      _showSucces();
    }
  }

  @override
  void initState() {
    role = Provider.of<AuthProvider>(context, listen: false).user.role;
    super.initState();
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
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
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
            Card(
              child: Container(
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
                            widget.fee.noInvoice,
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
                            'Fee Bulan',
                            style: TextStyle(),
                          ),
                          Text(
                            Config.formatBulan(widget.fee.tagihanBulan.toString()),
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
                            'Nama Guru',
                            style: TextStyle(),
                          ),
                          Text(
                            widget.fee.nama,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Jumlah Pertemuan',
                    //       ),
                    //       Text(
                    //         widget.fee.jumlah.toString(),
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
                          Text(
                            'Status',
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: widget.fee.status == 'Lunas' ? Colors.green : Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              // 'Lunas',
                              widget.fee.status,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          // Config.bedgeStatus(widget.fee.status)
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
                            Config.formatRupiah(int.parse(widget.fee.jumlah)),
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
                    role != "Guru" && widget.fee.status != 'Lunas'
                        ? Container(
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
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
