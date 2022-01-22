import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/model/notif_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemNotifikasi extends StatefulWidget {
  final NotifikasiModel data;
  const ItemNotifikasi({Key key, this.data}) : super(key: key);

  @override
  _ItemNotifikasiState createState() => _ItemNotifikasiState();
}

class _ItemNotifikasiState extends State<ItemNotifikasi> {
  readNotif(String id) {
    Provider.of<AuthProvider>(context, listen: false).readNotif(id: widget.data.id.toString()).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.data.status != 'Read') {
          readNotif(widget.data.id.toString());
        }
      },
      child: Container(
        color: Config.textWhite,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              margin: EdgeInsets.only(bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minWidth: 120, maxWidth: 310),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              widget.data.judul,
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                            ),
                                            widget.data.status != 'Read'
                                                ? new Container(
                                                    padding: EdgeInsets.all(0),
                                                    decoration: new BoxDecoration(
                                                      color: Config.boxBlue,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    constraints: BoxConstraints(
                                                      minWidth: 10,
                                                      minHeight: 10,
                                                    ),
                                                    child: Text(
                                                      ' ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 8,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  )
                                                : new Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      Config.formatDateInput(widget.data.createdAt.toString()),
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Text(
                  widget.data.konten,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Config.textGrey),
                )),
            Divider(height: 1)
          ],
        ),
      ),
    );
  }
}
