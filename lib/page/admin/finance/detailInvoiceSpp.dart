import 'package:bigstars_mobile/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvoiceSPP extends StatefulWidget {
  final String id;
  const InvoiceSPP({Key key, this.id}) : super(key: key);

  @override
  _InvoiceSPPState createState() => _InvoiceSPPState();
}

class _InvoiceSPPState extends State<InvoiceSPP> {
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
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Iya'),
          ),
        ],
      ),
    );
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
                            '#SPP2021111',
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
                            'Rinjani Rahayu',
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
                            '8',
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
                            'Belum Lunas',
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
                            Config.formatRupiah(800000),
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