import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListFee.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListReport.dart';
import 'package:bigstars_mobile/page/modal/modalFilterFee.dart';
import 'package:bigstars_mobile/page/modal/modalFilterReport.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:bigstars_mobile/service/finance_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<String> filter = [];
  String _filter = '';
  bool isLoading = false;

  void modelFilter(BuildContext context) {
    void filtered(nama, bulan, tahun) async {
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

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalFilterReport(
            // id: id,
            onsubmit: filtered,
          );
        });
  }

  @override
  void initState() {
    // getData();

    super.initState();
  }

  @override
  void dispose() {
    // Provider.of<FinanceProvider>(context, listen: false).getReport(_filter);

    super.dispose();
  }

  Future backPress(BuildContext context) => Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '2');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => backPress(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '2');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Config.primary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                filter = [];
                _filter = '';
                modelFilter(context);
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
            "Laporan Keuangan",
            style: TextStyle(color: Config.primary),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 16, bottom: 0),
            child: FutureBuilder(
                future: Provider.of<FinanceProvider>(context, listen: false).getReport(filtered: _filter),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<FinanceProvider>(builder: (context, data, _) {
                    return ListView.builder(
                        itemCount: data.ListReportModel.length,
                        itemBuilder: (BuildContext bc, int i) {
                          return ItemListReport(
                            report: data.ListReportModel[i],
                          );
                        });
                  });
                })),
      ),
    );
  }
}
