import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:flutter/material.dart';

class ItemListSiswa extends StatefulWidget {
  final dynamic data;
  const ItemListSiswa({Key key, this.data}) : super(key: key);

  @override
  _ItemListSiswaState createState() => _ItemListSiswaState();
}

class _ItemListSiswaState extends State<ItemListSiswa> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    widget.data['nama'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    widget.data["alamat"],
                    style: TextStyle(fontSize: 13, color: Config.textGrey),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.ADD_GURU, arguments: widget.data['id'].toString());
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
    );
  }
}
