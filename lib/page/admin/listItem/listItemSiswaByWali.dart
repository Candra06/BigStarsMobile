import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/provider/siswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ItemListSiswaByWali extends StatefulWidget {
  final SiswaModel data;
  const ItemListSiswaByWali({Key key, this.data}) : super(key: key);

  @override
  _ItemListSiswaByWaliState createState() => _ItemListSiswaByWaliState();
}

class _ItemListSiswaByWaliState extends State<ItemListSiswaByWali> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.nama,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanggal Lahir',
                      style: TextStyle(),
                    ),
                    Text(
                      Config.formatDateInput(widget.data.birthDate.toString()),
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Poin Siswa',
                      style: TextStyle(),
                    ),
                    Text(
                      widget.data.poinSiswa.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
