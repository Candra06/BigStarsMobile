import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/dashboard_wali.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemKelasTodayWali extends StatefulWidget {
  final KelasTodayWali data;
  const ItemKelasTodayWali({Key key, this.data}) : super(key: key);

  @override
  _ItemKelasTodayWaliState createState() => _ItemKelasTodayWaliState();
}

class _ItemKelasTodayWaliState extends State<ItemKelasTodayWali> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_KELAS_WALI, arguments: widget.data.idKelas.toString());
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(border: Border.all(width: 1, color: Config.borderInput), borderRadius: BorderRadius.circular(10)),
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
                        FontAwesomeIcons.clock,
                        color: Config.boxYellow,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        Config.formatJam(widget.data.jamMulai) + '-' + Config.formatJam(widget.data.jamSelesai),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Config.boxYellow,
                        ),
                      ),
                    ],
                  ),
                  Config.bedgeStatus(widget.data.status)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
