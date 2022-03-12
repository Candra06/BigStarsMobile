import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListFee.dart';
import 'package:bigstars_mobile/page/modal/modalFilterKelas.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FinancePageGuru extends StatefulWidget {
  const FinancePageGuru({Key key}) : super(key: key);

  @override
  _FinancePageGuruState createState() => _FinancePageGuruState();
}

class _FinancePageGuruState extends State<FinancePageGuru> {
  void _filter(BuildContext context, String id) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return ModalFilterKelas();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        automaticallyImplyLeading: false,
        title: Text(
          "Fee Guru",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        child: FutureBuilder(
          future: Provider.of<FinanceProvider>(context, listen: false).getFeeGuru(''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<FinanceProvider>(
              builder: (context, data, _) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.listFeeGuru.length,
                  itemBuilder: (BuildContext bc, int i) {
                    return ItemListFee(
                      fee: data.listFeeGuru[i],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
