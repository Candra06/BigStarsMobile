import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:flutter/material.dart';

class ItemListMapel extends StatefulWidget {
  final int id;
  final String mapel;
  const ItemListMapel({Key key, this.id, this.mapel}) : super(key: key);

  @override
  _ItemListMapelState createState() => _ItemListMapelState();
}

class _ItemListMapelState extends State<ItemListMapel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.mapel),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.ADD_MAPEL, arguments: widget.id.toString());
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
