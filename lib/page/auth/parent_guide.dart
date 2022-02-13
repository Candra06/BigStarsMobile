import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/page/auth/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyaratDanKetentuanWali extends StatefulWidget {
  const SyaratDanKetentuanWali({Key key}) : super(key: key);

  @override
  _SyaratDanKetentuanWaliState createState() => _SyaratDanKetentuanWaliState();
}

class _SyaratDanKetentuanWaliState extends State<SyaratDanKetentuanWali> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Parents Guide Bigstars Jember',
                  style: TextStyle(fontSize: 18, color: Config.primary, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Html(data: '''<p>Welcome to bigstars aplication</p>
<p>Yth<br />bpk/ibu walimurid bigstars berikut kami lampirkan mengenai panduan bimbingan belajar bigstars.jember</p>
<p>✍️ jadwal belajar flexibel / sesuai permintaan siswa<br />✍️ jadwal belajar bisa dirubah sewaktu2 dgn melalui konfirmasi terlebih dahulu.</p>
<p>✍️ member bigstars akan mendapat 2x gift<br />1. ketika sedang berulang tahun<br />2. reward belajar yg akan diberikan di tiap akhir tahun ajaran</p>
<p>✍️ member bigstars dpt mengklaim diskon member apabila berhasil membawa teman yang lain untk bergabung belajar bersama bigstars</p>
<p>✍️ dimohon member bigstars untuk selalu konfirmasi terlebih dahulu bila tidak les.</p>
<p>✍️ apabila guru telah datang di tempat murid,dan ternyata murid off tnpa konfirmasi maka akan di kenakan tagihan 1<br />/2 biaya dri harga les. (sebagai konpensasi uang bensin)</p>
<p>✍️apabila guru berhalangan datang maka pihak bigstars akan mengkonfirmasi untuk mengatur jadwal ganti hari atau digantikan oleh guru pengganti sementara.</p>
<p>✍️ biaya administrasi pembayaran les, akan dihitung permeeting, diakumulasi ditiap awal bulan dibayarkan melalui transfer pada nomer rekening yang telah ditetapkan.</p>'''),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString('setuju', 'true');
                  Navigator.of(context, rootNavigator: true).pushReplacement(PageTransition(child: LoginPage(), type: PageTransitionType.fade));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  primary: Config.primary,
                  onPrimary: Config.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Setuju",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
