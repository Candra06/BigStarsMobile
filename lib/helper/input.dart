import 'package:bigstars_mobile/helper/config.dart';
import 'package:flutter/material.dart';

Widget formInput(TextEditingController controller, label) {
  return Container(
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Config.borderInput)),
    child: Column(
      children: <Widget>[
        Container(
          child: TextFormField(
              style: TextStyle(color: Colors.black54),
              obscureText: false,
              keyboardType: TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                fillColor: Colors.black54,
                hintText: label,
                hintStyle: TextStyle(
                    // color: Config.textWhite,
                    fontSize: 16),
                border: InputBorder.none,
              )),
        )
      ],
    ),
  );
}
