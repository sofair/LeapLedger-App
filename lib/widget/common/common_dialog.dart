part of 'common.dart';

class CommonDialog {
  static Future<bool> showDeleteConfirmationDialog(BuildContext context, VoidCallback onConfirm) async {
    bool isFinish = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确认删除？'),
          content: const Text('你确定要删除吗？'),
          actions: [
            TextButton(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop<bool>(false);
                }),
            TextButton(
              child: const Text('确认'),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop<bool>(true);
              },
            ),
          ],
        );
      },
    ).then((value) => isFinish = value);
    return isFinish;
  }
}
