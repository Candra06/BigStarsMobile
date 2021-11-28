import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/wali_model.dart';
import 'package:flutter/material.dart';

class ItemListWali extends StatefulWidget {
  final WaliModel wali;
  const ItemListWali({Key key, this.wali}) : super(key: key);

  @override
  _ItemListWaliState createState() => _ItemListWaliState();
}

class _ItemListWaliState extends State<ItemListWali> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_WALI,
            arguments: widget.wali);
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.wali.nama,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.wali.status,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.wali.phone,
                          style:
                              TextStyle(fontSize: 13, color: Config.textGrey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.EDIT_WALI,
                                  arguments: widget.wali);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Config.primary,
                              size: 20,
                            )),
                      ],
                    )
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
