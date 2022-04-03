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
  bool load = false;
  readNotif(String id) {
    setState(() {
      load = true;
    });
    Provider.of<AuthProvider>(context, listen: false).readNotif(id: widget.data.id.toString()).then((value) {
      setState(() {
        load = false;
      });
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
        color: widget.data.status != 'Read' ? Colors.blue[50] : Config.textWhite,
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
                              Flexible(
                                child: Text(
                                  widget.data.judul ?? '-',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                Config.formatDateInput(widget.data.createdAt.toString()),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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
            if (load == true) ...{
              LinearProgressIndicator(),
            },
            Padding(
                padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Text(
                  widget.data.konten ?? '-',
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
