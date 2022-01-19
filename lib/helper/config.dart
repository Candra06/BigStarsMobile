import 'package:bigstars_mobile/helper/hexcolor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Config {
  static final HexColor primary = new HexColor('#FF7F00');
  static final HexColor secondary = new HexColor('#f4a427');
  static final HexColor darkPrimary = new HexColor('#00A2E9');
  static final HexColor textWhite = new HexColor('#ffffff');
  static final HexColor textAuth = new HexColor('#407a9d');
  static final HexColor textMerah = new HexColor('#e82b3f');
  static final HexColor textGrey = new HexColor('#B6B6B6');
  static final HexColor textBlack = new HexColor('#000000');
  static final HexColor textHeader = new HexColor('#1B2638');
  static final HexColor boxGreen = new HexColor('#4DC999');
  static final HexColor boxRed = new HexColor('#F75C5A');
  static final HexColor boxBlue = new HexColor('#36AFFC');
  static final HexColor boxGreenLight = new HexColor('#ACD1AF');
  static final HexColor boxYellow = new HexColor('#FBB229');
  static final HexColor boxYellowLight = new HexColor('#f1c40f');
  static final HexColor buttonRed = new HexColor('#FF0000');
  static final HexColor buttonGrey = new HexColor('#EAEAEA');
  static final HexColor textRed = new HexColor('#FF0000');
  static final HexColor onprogres = new HexColor('#FFA155');
  static final HexColor closed = new HexColor('#B3B3B3');
  static final HexColor open = new HexColor('#00C45C');
  static final HexColor background = new HexColor('#f8f8f8');
  static final HexColor borderInput = new HexColor('#BDBDBD');
  static final HexColor total = new HexColor('#7366FF');
  static final HexColor inActif = new HexColor('#E5E5E5');
  static final HexColor alertColor = new HexColor('#ED6363');

  // menampilkan loading berupa dialog
  static loading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              // backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitDoubleBounce(color: Config.primary, size: 50.0),
                      SizedBox(height: 30.0),
                      Text(
                        "Memuat Data",
                        style: GoogleFonts.lato(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )));
        });
  }

  static bedgeStatus(String status) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(color: status == 'Aktif' || status == 'Active' ? Config.boxGreen : Config.boxRed, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        status,
        style: TextStyle(color: Config.textWhite),
      ),
    );
  }

  static itemDetail(String title, konten) {
    return Column(
      children: [
        Container(
          color: Config.textWhite,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(
                konten,
                style: TextStyle(color: Config.textBlack, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Divider(height: 1)
      ],
    );
  }

  static emptyData(String pesan, context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width * 0.5, margin: EdgeInsets.only(top: 20, bottom: 10), child: Image.asset('assets/images/box.png')),
          Text(
            pesan,
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
            // style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ],
      ),
    );
  }

  static alert(tipe, pesan) {
    Fluttertoast.showToast(
        msg: pesan,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: (tipe == 1 ? Colors.green : Colors.red), // 1 untuk berhasil
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // menampilkan loading 1 page penuh
  static loader(pesan) {
    return Center(
      child: Container(
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCube(color: Config.primary, size: 50.0),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: new Text(
                  pesan,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static showSuccesAdd(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              // height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/success-delete.json'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(message),
                ],
              ),
            ),
            actions: [
              Container(
                width: double.infinity - 30,
                height: 60,
                decoration: BoxDecoration(
                  color: Config.boxGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  // textColor: Color(0xFF6200EE),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ACCEPT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  static formatDateInput(tgl) {
    try {
      var date = tgl.split(" ");
      var bln = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
      var bulan = date[0].toString().split('-');
      String tanggal = bulan[2] + ' ' + bln[int.parse(bulan[1])] + ' ' + bulan[0];
      return tanggal;
    } catch (e) {
      return tgl.toString();
    }
  }

  static formatDateTime(tgl) {
    try {
      var date = tgl.toString().split("T");
      var bln = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
      var tmpDate = date[0].toString().split(" ");
      var bulan = tmpDate[0].toString().split('-');
      String tanggal = bulan[2] + ' ' + bln[int.parse(bulan[1])] + ' ' + bulan[0];
      return tanggal;
    } catch (e) {
      print(e);
      return tgl.toString();
    }
  }

  static formatDateTimeJam(tgl) {
    try {
      print(tgl);
      var date = tgl.toString().split(" ");
      var jam = date[1].toString().split('.');
      print(jam);
      String tanggal = jam[0];
      return tanggal;
    } catch (e) {
      print(e);
      return tgl.toString();
    }
  }

  static formatJam(jam) {
    try {
      var hour = jam.split(":");

      String waktu = hour[0] + ':' + hour[1];
      return waktu;
    } catch (e) {
      print(e);
      return jam.toString();
    }
  }

  static formatRupiah(int nominal) {
    try {
      return (new NumberFormat.currency(
        locale: "id_IDR",
        symbol: "Rp. ",
        decimalDigits: 0,
      )).format(nominal);
    } catch (e) {
      return nominal.toString();
    }
  }
}
