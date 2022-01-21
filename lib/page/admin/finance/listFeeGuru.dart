import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/itemListFee.dart';
import 'package:bigstars_mobile/page/modal/modalFilterFee.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:bigstars_mobile/service/finance_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ListFeeGuru extends StatefulWidget {
  const ListFeeGuru({Key key}) : super(key: key);

  @override
  _ListFeeGuruState createState() => _ListFeeGuruState();
}

class _ListFeeGuruState extends State<ListFeeGuru> {
  List<String> filter = [];
  String _filter = '';
  List<dynamic> _listSPP = [];
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

  void generateFee() async {
    setState(() {
      isLoading = true;
    });

    await Provider.of<FinanceProvider>(context, listen: false).generateFEE().then((value) {
      if (value) {
        _showSuccesAdd();
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  void modelFilter(BuildContext context) {
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
          return ModalFilterFee(
            // id: id,
            onsubmit: filtered,
          );
        });
  }

  getData() async {
    await FinanceService().feeGuru(_filter);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget generateFeebtn() {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: ElevatedButton(
          onPressed: () {
            generateFee();
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
            "Generate Fee Guru",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }

    Widget loadGenerateFeebtn() {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 30),
            primary: Config.primary,
            onPrimary: Config.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Loading",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

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
          "Fee Guru",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        // child: ListView.builder(
        //     itemCount: 3,
        //     itemBuilder: (BuildContext bc, int i) {
        //       return ItemListFee();
        //     }),
        child: Column(
          children: [
            isLoading ? loadGenerateFeebtn() : generateFeebtn(),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Provider.of<FinanceProvider>(context, listen: false).getFeeGuru(_filter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Consumer<FinanceProvider>(
                  builder: (context, data, _) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.ListFeeGuru.length,
                      itemBuilder: (BuildContext bc, int i) {
                        return ItemListFee(
                          fee: data.ListFeeGuru[i],
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
