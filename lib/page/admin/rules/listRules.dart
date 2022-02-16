import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/provider/rules_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRulesPage extends StatefulWidget {
  const ListRulesPage({Key key}) : super(key: key);

  @override
  _ListRulesPageState createState() => _ListRulesPageState();
}

class _ListRulesPageState extends State<ListRulesPage> {
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
          'Pengaturan Rules Pengguna',
          style: TextStyle(color: Config.primary),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<RulesProvider>(context, listen: false).getRules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          return RefreshIndicator(
            onRefresh: () {
              return Provider.of<RulesProvider>(context, listen: false).getRules();
            },
            child: Consumer<RulesProvider>(
              builder: (context, value, child) {
                return Container(
                  margin: EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: value.rules.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.DETAIL_RULES_SETTING, arguments: value.rules[index]);
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Rules ' + value.rules[index].rulesFor),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
