import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ItemListSiswa extends StatefulWidget {
  final SiswaModel data;
  const ItemListSiswa({Key key, this.data}) : super(key: key);

  @override
  _ItemListSiswaState createState() => _ItemListSiswaState();
}

class _ItemListSiswaState extends State<ItemListSiswa> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_SISWA, arguments: widget.data);
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data.nama,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      widget.data.status,
                      style: TextStyle(fontSize: 13, color: Config.textGrey),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.data.alamat,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Config.textGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
