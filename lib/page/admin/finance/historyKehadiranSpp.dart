import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/DetailSpp_model.dart';
import 'package:bigstars_mobile/model/spp_model.dart';
import 'package:bigstars_mobile/provider/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryKehadiranSPP extends StatefulWidget {
  final List<HistoriKehadiran> historiKehadiran;
  const HistoryKehadiranSPP({Key key, this.historiKehadiran}) : super(key: key);

  @override
  _HistoryKehadiranSPPState createState() => _HistoryKehadiranSPPState();
}

class _HistoryKehadiranSPPState extends State<HistoryKehadiranSPP> {
  bool load = true;

  String role;

  @override
  void initState() {
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
          "Riwayat Kehadiran",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: ListView.builder(
            itemCount: widget.historiKehadiran.length,
            itemBuilder: (BuildContext bc, int i) {
              return Container(
                color: Config.textWhite,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.historiKehadiran[i].mapel),
                        Text(widget.historiKehadiran[i].nama),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.historiKehadiran[i].materi),
                        Text(Config.formatRupiah(widget.historiKehadiran[i].spp)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(Config.formatDateTime(widget.historiKehadiran[i].createdAt) + ' ' + Config.formatDateTimeJam(widget.historiKehadiran[i].createdAt)),
                    SizedBox(
                      height: 4,
                    ),
                    Divider()
                  ],
                ),
              );
            }),
      ),
    );
  }
}
