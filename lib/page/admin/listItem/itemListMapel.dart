import 'package:bigstars_mobile/helper/config.dart';

import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';

import 'package:bigstars_mobile/provider/mapel_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
        _showSuccesHapus();
      }
    });
  }

  handleHapus() async {
    await hapusMapel(context);
  }

  _showConfirmHapus() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/warning-animation.json',
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text('Are you sure to delete ?'),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.alertColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    // width: double.infinity - 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Config.boxGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        handleHapus();
                      },
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  _showSuccesHapus() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              // height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/success-delete.json'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Data has been deleted!'),
                ],
              ),
            ),
            actions: [
              Container(
                width: double.infinity - 30,
                height: 60,
                decoration: BoxDecoration(
                  color: Config.boxGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  // textColor: Color(0xFF6200EE),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ACCEPT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
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
                        // hapusMapel(context);
                        // _showSuccesHapus();
                        _showConfirmHapus();
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
