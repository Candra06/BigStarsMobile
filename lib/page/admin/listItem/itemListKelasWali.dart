import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemKelasWali extends StatefulWidget {
  final dynamic data;
  const ItemKelasWali({Key key, this.data}) : super(key: key);

  @override
  _ItemKelasWaliState createState() => _ItemKelasWaliState();
}

class _ItemKelasWaliState extends State<ItemKelasWali> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_KELAS_WALI);
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
                    widget.data['siswa'],
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                  Text(
                    widget.data['mapel'],
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
                    widget.data['guru'],
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
                        widget.data['jam_mulai'] + '-' + widget.data['jam_selesai'],
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Config.boxYellow,
                        ),
                      ),
                    ],
                  ),
                  Config.bedgeStatus('Inactive')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
