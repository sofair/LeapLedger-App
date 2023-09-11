part of 'util.dart';

class FileOperation {
  static Future<File?> selectFile(FileType type, List<String>? allowedExtensions) async {
    if ((await Permission.storage.request()).isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
      );
      if (result != null) {
        return File(result.files.single.path!);
      }
    }
    return null;
  }
}
