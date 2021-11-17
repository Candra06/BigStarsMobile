import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/admin/listItem/listItemWali.dart';
import 'package:flutter/material.dart';

class ListWali extends StatefulWidget {
  const ListWali({Key key}) : super(key: key);

  @override
  _ListWaliState createState() => _ListWaliState();
}

class _ListWaliState extends State<ListWali> {
  bool load = false;
  String searchString = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? LinearProgressIndicator(
              color: Config.primary,
              backgroundColor: Config.boxYellowLight,
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              style: TextStyle(color: Colors.black54),
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  searchString = value;
                                });
                              },
                              // controller: controller,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.black54,
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Config.textGrey,
                                ),
                                hintText: 'Cari Nama',
                                hintStyle: TextStyle(
                                    // color: Config.textWhite,
                                    fontSize: 16),
                                border: InputBorder.none,
                              )),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int i) {
                        var data = {"id": '1', 'nama': 'Wali 1', 'phone': '087757654999', 'status': 'Active'};
                        return ItemListWali(
                          data: data,
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
