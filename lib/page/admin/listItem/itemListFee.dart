import 'package:bigstars_mobile/helper/config.dart';

import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemListFee extends StatefulWidget {
  final FeeGuruModel fee;
  const ItemListFee({Key key, this.fee}) : super(key: key);

  @override
  _ItemListFeeState createState() => _ItemListFeeState();
}

class _ItemListFeeState extends State<ItemListFee> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_FEE, arguments: '1');
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
                    FontAwesomeIcons.receipt,
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
                                  widget.fee.nama,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  Config.formatDateInput(
                                      widget.fee.tagihanBulan),
                                  style: TextStyle(color: Config.textGrey),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    Config.formatRupiah(widget.fee.jumlah),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.fee.status,
                                    style: TextStyle(color: Colors.green),
                                  )
                                ],
                              ),
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
