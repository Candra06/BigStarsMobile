import 'package:bigstars_mobile/helper/config.dart';
import 'package:flutter/material.dart';

class ItemListKehadiran extends StatefulWidget {
  final Map<dynamic, String> data;
  const ItemListKehadiran({Key key, this.data}) : super(key: key);

  @override
  _ItemListKehadiranState createState() => _ItemListKehadiranState();
}

class _ItemListKehadiranState extends State<ItemListKehadiran> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  widget.data['nama'],
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  widget.data['hari'],
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
                  widget.data['materi'],
                ),
                Text(
                  widget.data['status'],
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
              widget.data['jurnal'],
              maxLines: 3,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                print(widget.data['file_materi']);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 30),
                primary: Config.primary,
                onPrimary: Config.textWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                "Unduh Materi",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}