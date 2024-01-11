part of 'enter.dart';

class FileOperation {
  static Future<File?> selectFile(FileType type, List<String>? allowedExtensions) async {
    if ((await Permission.manageExternalStorage.request()).isGranted) {
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

  static Future<bool> saveImage(Uint8List imageBytes) async {
    if (false == (await Permission.manageExternalStorage.request()).isGranted) {
      return false;
    }

    try {
      Directory tempDir = await getTemporaryDirectory();
      File file = File('${tempDir.path}/example.png');
      await file.writeAsBytes(imageBytes);

      Directory? storageDir = await getExternalStorageDirectory();
      if (storageDir == null) {
        return false;
      }

      String newPath = '${storageDir.path}/example.png';
      await file.copy(newPath);

      return true;
    } catch (e) {
      return false;
    }
  }
}
