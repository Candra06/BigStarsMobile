import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/spp_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemListSPP extends StatefulWidget {
  final SppModel data;
  const ItemListSPP({Key key, this.data}) : super(key: key);

  @override
  _ItemListSPPState createState() => _ItemListSPPState();
}

class _ItemListSPPState extends State<ItemListSPP> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_SPP, arguments: '1');
      },
      child: Container(
        color: Config.textWhite,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              margin: EdgeInsets.only(bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.handHoldingUsd,
                    size: 30,
                    color: Config.primary,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minWidth: 120, maxWidth: 310),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.nama,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  Config.formatDateInput(
                                      widget.data.tagihanBulan),
                                  style: TextStyle(color: Config.textGrey),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Config.formatRupiah(
                                      int.parse(widget.data.jumlah)),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.data.status,
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1)
          ],
        ),
      ),
    );
  }
}
