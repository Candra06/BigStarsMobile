import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListFee.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListSPP.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FinancePageWali extends StatefulWidget {
  const FinancePageWali({Key key}) : super(key: key);

  @override
  _FinancePageWaliState createState() => _FinancePageWaliState();
}

class _FinancePageWaliState extends State<FinancePageWali> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Config.textWhite,
          title: Text(
            "SPP Siswa",
            style: TextStyle(color: Config.primary),
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<FinanceProvider>(context, listen: false).getSpp(''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }
            return Consumer<FinanceProvider>(
              builder: (context, value, child) {
                return value.ListSppModel.length == 0
                    ? Center(
                        child: Text('Belum ada tagihan SPP'),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.ListSppModel.length,
                                itemBuilder: (BuildContext bc, int i) {
                                  return ItemListSPP(
                                    data: value.ListSppModel[i],
                                  );
                                }),
                          ],
                        ),
                      );
              },
            );
          },
        ));
  }
}
