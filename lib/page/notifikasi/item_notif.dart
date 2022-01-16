import 'package:bigstars_mobile/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemNotifikasi extends StatefulWidget {
  final Map<dynamic, String> data;
  const ItemNotifikasi({Key key, this.data}) : super(key: key);

  @override
  _ItemNotifikasiState createState() => _ItemNotifikasiState();
}

class _ItemNotifikasiState extends State<ItemNotifikasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Config.textWhite,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            margin: EdgeInsets.only(bottom: 8),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(minWidth: 120, maxWidth: 310),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Siswa',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    Config.formatDateInput("2021-10-21"),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                'Nama Siswa Siswa Siswa baru saja merayakan hari ulang tahun. Ucapkan selamat kepada mereka!',
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(color: Config.textGrey),
              )),
          Divider(height: 1)
        ],
      ),
    );
  }
}
