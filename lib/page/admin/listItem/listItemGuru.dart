import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/provider/guru_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ItemListGuru extends StatefulWidget {
  final GuruModel guru;
  const ItemListGuru({Key key, this.guru}) : super(key: key);

  @override
  _ItemListGuruState createState() => _ItemListGuruState();
}

class _ItemListGuruState extends State<ItemListGuru> {
  handleHapus() async {
    bool status = await Provider.of<GuruProvider>(context, listen: false)
        .delete(widget.guru.id);
    print(status);
    if (status) {
      _showSuccesHapus();
    }
    // print(status);
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
                          var data = {"id": "1", "guru": widget.guru};
                          Navigator.pushNamed(context, Routes.ADD_GURU,
                              arguments: data);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Config.primary,
                        )),
                    IconButton(
                        onPressed: _showConfirmHapus,
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
