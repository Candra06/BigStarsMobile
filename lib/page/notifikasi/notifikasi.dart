import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/notifikasi/item_notif.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: FutureBuilder(
        future: Provider.of<AuthProvider>(context, listen: false).getNotif(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          return RefreshIndicator(
            onRefresh: () {
              return Provider.of<AuthProvider>(context, listen: false).getNotif();
            },
            child: Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              child: Consumer<AuthProvider>(
                builder: (context, data, _) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.listNotif.length,
                      itemBuilder: (BuildContext bc, int i) {
                        return ItemNotifikasi(
                          data: data.listNotif[i],
                        );
                        // return Container();
                      });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
