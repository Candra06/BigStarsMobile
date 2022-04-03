import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/page/modal/addKehadiranGuru.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ItemListKehadiranWali extends StatefulWidget {
  final ListKehadiran data;
  const ItemListKehadiranWali({Key key, this.data}) : super(key: key);

  @override
  _ItemListKehadiranWaliState createState() => _ItemListKehadiranWaliState();
}

class _ItemListKehadiranWaliState extends State<ItemListKehadiranWali> {
  void aksi() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: new Wrap(
            children: [
              if (widget.data.fileMateri != '-') ...{
                new ListTile(
                  leading: new Icon(Icons.download),
                  title: new Text('Download Materi'),
                  onTap: () async {
                    String url = EndPoint.server + widget.data.fileMateri;
                    //       print(url);
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw "Could not launch $url";
                    }
                  },
                ),
              } else ...{
                new ListTile(
                  leading: new Icon(Icons.download),
                  title: new Text('Download Materi'),
                  onTap: () {
                    return Config.alert(0, 'Tutor tidak mengunggah materi pada pertemuan ini');
                  },
                ),
              },
            ],
          ),
        );
      },
    );
  }

  void detail(String jurnal) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Text(
                'Detail Jurnal',
                style: TextStyle(fontWeight: FontWeight.bold, color: Config.textGrey),
              ),
              SizedBox(
                height: 10,
              ),
              Text(jurnal),
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        detail(widget.data.jurnal);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        color: Config.textWhite,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.nama,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    Config.formatDateTime(widget.data.createdAt.toString()),
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.materi,
                  ),
                  Text(
                    widget.data.status,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Jurnal',
              ),
              Text(
                widget.data.jurnal,
                maxLines: 3,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Config.formatDateTime(widget.data.createdAt.toString()) + ' ' + Config.formatDateTimeJam(widget.data.createdAt.toString()),
                  ),
                  IconButton(
                      onPressed: () {
                        aksi();
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Config.textGrey,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
