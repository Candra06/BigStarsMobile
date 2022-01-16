import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/notifikasi/item_notif.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Config.primary,
          ),
        ),
        backgroundColor: Config.textWhite,
        title: Text(
          "Notifikasi",
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext bc, int i) {
                  return ItemNotifikasi();
                  // return Container();
                }),
          ],
        ),
      ),
    );
  }
}
