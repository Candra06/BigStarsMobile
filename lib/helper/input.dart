import 'package:bigstars_mobile/helper/config.dart';
import 'package:file_picker/file_picker.dart';
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

Widget formInputType(TextEditingController controller, label, TextInputType type) {
  return Container(
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
    child: Column(
      children: <Widget>[
        Container(
          child: TextFormField(
              style: TextStyle(color: Colors.black54),
              obscureText: false,
              keyboardType: type,
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

Widget formInputMultiline(TextEditingController controller, label) {
  return Container(
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Config.borderInput)),
    child: Column(
      children: <Widget>[
        Container(
          child: TextFormField(
              style: TextStyle(color: Colors.black54),
              obscureText: false,
              keyboardType: TextInputType.text,
              controller: controller,
              maxLines: 3,
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

class FormInputFile extends StatefulWidget {
  final VoidCallback onTap;
  final PlatformFile label;
  const FormInputFile({
    Key key,
    this.onTap,
    this.label,
  }) : super(key: key);

  @override
  _FormInputFileState createState() => _FormInputFileState();
}

class _FormInputFileState extends State<FormInputFile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[300],
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: InkWell(
        highlightColor: Colors.white.withOpacity(0.5),
        onTap: () {
          this.widget.onTap();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    widget.label == null ? "Pilih File" : widget.label.name.toString(),
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Theme.of(context).textTheme.caption.color,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
