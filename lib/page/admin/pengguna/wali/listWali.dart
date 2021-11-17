import 'package:bigstars_mobile/helper/config.dart';
import 'package:flutter/material.dart';

class ListWali extends StatefulWidget {
  const ListWali({Key key}) : super(key: key);

  @override
  _ListWaliState createState() => _ListWaliState();
}

class _ListWaliState extends State<ListWali> {
  bool load = true;
  @override
  void initState() {
    load = true;
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
          : ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int i) {
                return Container();
              }),
    );
  }
}
