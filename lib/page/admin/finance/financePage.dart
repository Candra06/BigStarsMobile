import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/finance_model.dart';
import 'package:bigstars_mobile/page/modal/modalFilterReport.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:bigstars_mobile/service/finance_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({Key key}) : super(key: key);

  @override
  _FinancePageState createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  FinanceModel financeModel = FinanceModel();
  bool load = false;
  int laba;
  int totalSpp;
  int totalFee;
  List<String> filter = [];
  String _filter = '';

  void modelFilter(BuildContext context) {
    void filtered(nama, bulan, tahun) async {
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
        getData();
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

  getData() async {
    setState(() {
      load = true;
    });
    // FinanceProvider financeProvider =
    //     Provider.of<FinanceProvider>(context, listen: false);
    // financeModel = financeProvider.Finance;

    financeModel = await Provider.of<FinanceProvider>(context, listen: false).getFinance(_filter);
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        automaticallyImplyLeading: false,
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
        title: Text(
          "Keuangan",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Config.primary, borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Laba Bersih',
                          style: TextStyle(color: Config.textWhite, fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Config.formatRupiah(financeModel.laba),
                          style: TextStyle(color: Config.textWhite, fontSize: 24, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Config.textWhite,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          // width: MediaQuery.of(context).size.width,

                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'SPP Siswa',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.green,
                                    size: 50,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                Config.formatRupiah(financeModel.totalSpp),
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Config.textWhite,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          // width: MediaQuery.of(context).size.width,

                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Fee Guru',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_up_sharp,
                                    color: Colors.red,
                                    size: 50,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                Config.formatRupiah(financeModel.totalFee),
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.LIST_SPP);
                        },
                        child: Container(
                            height: 90,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/icons/iconSPP.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('SPP Murid')
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.LIST_FEE);
                        },
                        child: Container(
                            height: 90,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/icons/iconFee.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Fee Guru')
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.REPORT);
                        },
                        child: Container(
                            height: 90,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Config.borderInput, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/icons/iconReport.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Report')
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
