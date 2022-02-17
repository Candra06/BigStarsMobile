import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/dashboardGuru_model.dart';
import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemKelasGuru extends StatefulWidget {
  final KelasModel data;
  const ItemKelasGuru({Key key, this.data}) : super(key: key);

  @override
  _ItemKelasGuruState createState() => _ItemKelasGuruState();
}

class _ItemKelasGuruState extends State<ItemKelasGuru> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_KELAS_GURU, arguments: widget.data.id.toString());
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
                  Container(
                    // margin: EdgeInsets.all(8),
                    child: Config.bedgeStatus(widget.data.status),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    'Mapel',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8, top: 8),
                  child: Text(
                    widget.data.mapel,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    'Jumlah Pertemuan ',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8, top: 8),
                  child: Text(
                    widget.data.jumlahPertemuan,
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 13),
                  ),
                ),
              ],
            ),
            Divider(),
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
                        widget.data.jamMulai + '-' + widget.data.jamSelesai,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Config.boxYellow,
                        ),
                      ),
                    ],
                  ),
                  // Config.bedgeStatus(widget.data.status)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
