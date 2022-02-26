import 'package:bigstars_mobile/helper/config.dart';

import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';
import 'package:bigstars_mobile/model/report_model.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemListReport extends StatefulWidget {
  final ReportModel report;
  const ItemListReport({Key key, this.report}) : super(key: key);

  @override
  _ItemListReportState createState() => _ItemListReportState();
}

class _ItemListReportState extends State<ItemListReport> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_FEE, arguments: widget.report);
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
                    widget.report.tipe == 'FEE' ? FontAwesomeIcons.receipt : FontAwesomeIcons.handHoldingUsd,
                    size: 30,
                    color: Config.primary,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minWidth: 120, maxWidth: 310),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.report.nama,
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                Config.formatRupiah(int.parse(widget.report.nominal)),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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
                                Config.formatBulan(widget.report.tagihanBulan.toString()),
                                style: TextStyle(color: Config.textGrey),
                              ),
                              Text(
                                widget.report.status,
                                style: TextStyle(color: widget.report.status == 'Lunas' ? Colors.green : Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  // Expanded(
                  //   child: Container(
                  //     constraints: BoxConstraints(minWidth: 120, maxWidth: 310),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 widget.report.nama,
                  //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               Text(
                  //                 Config.formatBulan(widget.report.tagihanBulan.toString()),
                  //                 style: TextStyle(color: Config.textGrey),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: Container(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.end,
                  //               children: [
                  //                 Text(
                  //                   Config.formatRupiah(int.parse(widget.report.nominal.toString())),
                  //                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 8,
                  //                 ),
                  //                 Text(
                  //                   widget.report.status,
                  //                   style: TextStyle(color: widget.report.status == 'Lunas' ? Colors.green : Colors.red),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
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
