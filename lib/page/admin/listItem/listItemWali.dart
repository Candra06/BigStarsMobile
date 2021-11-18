import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:flutter/material.dart';

class ItemListWali extends StatefulWidget {
  final dynamic data;
  const ItemListWali({Key key, this.data}) : super(key: key);

  @override
  _ItemListWaliState createState() => _ItemListWaliState();
}

class _ItemListWaliState extends State<ItemListWali> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_WALI, arguments: widget.data['id'].toString());
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
                          widget.data['nama'],
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.data['status'],
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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
                          widget.data["phone"],
                          style: TextStyle(fontSize: 13, color: Config.textGrey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.EDIT_WALI, arguments: widget.data['id'].toString());
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
