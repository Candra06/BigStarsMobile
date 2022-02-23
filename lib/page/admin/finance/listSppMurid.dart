import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/input.dart';
import 'package:bigstars_mobile/helper/route.dart';
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

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return ModalFilterSPP(
            // id: id,
            onsubmit: filtered,
          );
        });
  }

  bool isLoading = false;
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

  Future backPress(BuildContext context) => Navigator.pushNamed(context, Routes.HOME_ADMIN, arguments: '2');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return backPress(context);
      },
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
                // Navigator.pop(context);
                modalFilter(context);
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
          child: FutureBuilder(
              future: Provider.of<FinanceProvider>(context, listen: false).getSpp(_filter),
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
                      
                      itemBuilder: (BuildContext bc, int i) {
                        return ItemListSPP(
                          data: data.ListSppModel[i],
                        );
                      },
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
