import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/page/admin/mapel/addMapel.dart';
import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListMapel extends StatefulWidget {
  // final int id;
  // final String mapel;
  final MapelModel mapelModel;
  const ItemListMapel({Key key, this.mapelModel}) : super(key: key);

  @override
  _ItemListMapelState createState() => _ItemListMapelState();
}

class _ItemListMapelState extends State<ItemListMapel> {
  hapusMapel(context) {
    Provider.of<MapelProvider>(context, listen: false)
        .hapusMapel(widget.mapelModel.id.toString())
        .then((value) {
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Config.primary,
            content: Text(
              "Data Mapel Berhasil dihapus",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });

    // print(EndPoint.mDelete + widget.mapelModel.id.toString());
  }

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
              Expanded(
                child: Text(
                  widget.mapelModel.mapel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // print(widget.mapelModel.id.toString());
                      Provider.of<MapelProvider>(context, listen: false)
                          .getMapel(widget.mapelModel.id.toString());
                      var data = {'id': '1', 'mapel': widget.mapelModel};
                      Navigator.pushNamed(
                        context,
                        Routes.ADD_MAPEL,
                        arguments: data,
                        // arguments: MapelModel()
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Config.primary,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        hapusMapel(context);
                      },
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
