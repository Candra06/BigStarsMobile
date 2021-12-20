import 'package:bigstars_mobile/helper/config.dart';
import 'package:file_picker/file_picker.dart';

class FileUpload {
  Future<PlatformFile> uploadFile({
    List<String> allowedExtensions,
  }) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result != null) {
      PlatformFile file = result.files.single;
      // Cek apabila ukuran file lebih dari 10 mb
      if (file.size > 1048576 * 10) {
        Config.alert(0, "Ukuran file tidak boleh melebihi 10 mb");
        return null;
      }
      return file;
    }
    return null;
  }
}
