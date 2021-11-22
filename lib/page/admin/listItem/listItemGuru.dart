import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:flutter/material.dart';

class ItemListGuru extends StatefulWidget {
  final GuruModel guru;
  const ItemListGuru({Key key, this.guru}) : super(key: key);

  @override
  _ItemListGuruState createState() => _ItemListGuruState();
}

class _ItemListGuruState extends State<ItemListGuru> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_GURU,
            arguments: widget.guru);
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.guru.nama,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      widget.guru.phone,
                      style: TextStyle(fontSize: 13, color: Config.textGrey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.ADD_GURU,
                              arguments: widget.guru.id.toString());
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Config.primary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: Config.textRed,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
