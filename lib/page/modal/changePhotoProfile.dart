import 'dart:convert';
import 'dart:io';

import 'package:bigstars_mobile/helper/config.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/helper/route.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModalChangePhotoProfile extends StatefulWidget {
  const ModalChangePhotoProfile({Key key}) : super(key: key);

  @override
  _ModalChangePhotoProfileState createState() => _ModalChangePhotoProfileState();
}

class _ModalChangePhotoProfileState extends State<ModalChangePhotoProfile> {
  File tmpFile;

  Future<File> file;

  String fileName = '';
  Map<dynamic, dynamic> data;
  UserModel user;

  void edit(BuildContext context) async {
    String role = await Pref.getRole();
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    data = await Provider.of<AuthProvider>(context, listen: false).editFoto(tmpFile);
    user = authProvider.user;
    print(data);
    if (data["status"] == true) {
      // SharedPreferences pref = await SharedPreferences.getInstance();
      print(user.toJson());

      // pref.setString('user', json.encode(user.toJson()));
      Config.alert(1, 'Berhasil mengubah foto');

      if (role == 'Admin') {
        Navigator.pushNamed(context, Routes.PROFILE_ADMIN);
      } else if (role == 'Guru') {
        Navigator.pushNamed(context, Routes.PROFILE_GURU);
      } else {
        Navigator.pushNamed(context, Routes.PROFILE_WALI);
      }
    } else {
      Config.alert(0, 'Gagal mengubah foto');
    }
  }

  Future _getImage() async {
    final picker = ImagePicker();
    PickedFile pickedFile;
    final imgSrc = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pilih sumber gambar"),
        actions: <Widget>[
          MaterialButton(
            child: Text("Kamera"),
            onPressed: () async {
              Navigator.pop(context, ImageSource.camera);

              pickedFile = await picker.getImage(source: ImageSource.camera);

              setState(() {
                if (pickedFile?.path == null) {
                  fileName = '';
                } else {
                  fileName = pickedFile.path.toString();
                  tmpFile = File(pickedFile.path);
                  print(fileName);
                }
              });
            },
          ),
          MaterialButton(
              child: Text("Galeri"),
              onPressed: () async {
                Navigator.pop(context, ImageSource.gallery);
                pickedFile = await picker.getImage(source: ImageSource.gallery);
                setState(() {
                  if (pickedFile?.path == null) {
                    fileName = '';
                  } else {
                    fileName = pickedFile.path.toString();
                    tmpFile = File(pickedFile.path);
                    print(fileName);
                  }
                });
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah Foto Profil'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            fileName.isEmpty ? Text('Pilih Foto') : Image.file(tmpFile),
            Container(
              width: 200,
              child: OutlinedButton(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload, color: Config.textBlack),
                    Text(
                      'Upload Image',
                      style: TextStyle(color: Config.textBlack),
                    ),
                  ],
                ),
                onPressed: () {
                  _getImage();
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Batal',
            style: TextStyle(color: Config.textGrey),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Simpan',
            style: TextStyle(color: Config.primary),
          ),
          onPressed: () {
            if (tmpFile.path.toString().isEmpty) {
              Config.alert(0, 'Harap pilih foto profil');
            } else {
              edit(context);
            }
          },
        ),
      ],
    );
  }
}
