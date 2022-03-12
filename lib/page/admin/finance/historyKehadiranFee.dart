import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/DetailFee_model.dart';
import 'package:flutter/material.dart';

class HistoryKehadiranFee extends StatefulWidget {
  final List<HistoriKehadiranGuru> historiKehadiran;
  const HistoryKehadiranFee({Key key, this.historiKehadiran}) : super(key: key);

  @override
  _HistoryKehadiranFeeState createState() => _HistoryKehadiranFeeState();
}

class _HistoryKehadiranFeeState extends State<HistoryKehadiranFee> {
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
                        Flexible(
                          child: Text(
                            widget.historiKehadiran[i].materi,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(Config.formatRupiah(widget.historiKehadiran[i].feePengajar)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Config.formatDateTime(widget.historiKehadiran[i].createdAt) + ' ' + Config.formatDateTimeJam(widget.historiKehadiran[i].createdAt)),
                        Text(widget.historiKehadiran[i].tipe),
                      ],
                    ),
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
