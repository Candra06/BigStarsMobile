import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/kelasToday_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemKelasToday extends StatefulWidget {
  final KelasToday data;
  const ItemKelasToday({Key key, this.data}) : super(key: key);

  @override
  _ItemKelasTodayState createState() => _ItemKelasTodayState();
}

class _ItemKelasTodayState extends State<ItemKelasToday> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_KELAS,
            arguments: widget.data);
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Config.borderInput),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.siswa,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                  Text(
                    widget.data.mapel,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  child: Text(
                    widget.data.guru,
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: Text(
                    widget.data.status,
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 13,
                        color: Config.boxGreen),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.moneyBillAlt,
                        color: Config.boxGreen,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        Config.formatRupiah(int.parse(widget.data.spp)),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Config.boxGreen,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        Config.formatJam(widget.data.jamMulai) +
                            '-' +
                            Config.formatJam(widget.data.jamSelesai),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Config.boxRed,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      FaIcon(
                        FontAwesomeIcons.clock,
                        color: Config.boxRed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
