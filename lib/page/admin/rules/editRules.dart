import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/rules_model.dart';
import 'package:bigstars_mobile/provider/rules_provider.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:provider/provider.dart';
// import 'package:html_editor_enhanced/html_editor.dart';

class EditRules extends StatefulWidget {
  final RulesModel rules;
  const EditRules({Key key, this.rules}) : super(key: key);

  @override
  _EditRulesState createState() => _EditRulesState();
}

class _EditRulesState extends State<EditRules> {
  // HtmlEditorController controller = HtmlEditorController();

  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  String value = '';
  bool isloading = true;

  void update() async {
    Config.loading(context);

    Map<String, dynamic> data = {
      'rules': value,
    };

    bool request = await Provider.of<RulesProvider>(context, listen: false).update(widget.rules.id.toString(), data);

    if (request == true) {
      Navigator.pushNamed(context, Routes.RULES_SETTING);
      Config.alert(1, 'Berhasil megubah rules');
    } else {
      Navigator.pop(context);
      Config.alert(0, 'Gagal megubah rules');
    }

    // print(data);
  }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.textWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Config.primary,
            )),
        title: Text(
          'Edit Rules ' + widget.rules.rulesFor,
          style: TextStyle(color: Config.primary),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Config.primary,
        onPressed: () async {
          value = await keyEditor.currentState.getText();

          update();
        },
        child: Icon(Icons.save),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: HtmlEditor(
          value: widget.rules.rules,
          
          //value: "text content initial, if any",
          key: keyEditor,
          useBottomSheet: false,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
