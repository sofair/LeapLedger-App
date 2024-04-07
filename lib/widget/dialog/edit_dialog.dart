part of 'enter.dart';

@Deprecated('Use [CommonDialog.edit] instead')

/// 已弃用 改用[CommonDialog.edit]
class EditDialog extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final String? name;
  final String title, value;
  final Function(String value) onSubmit;
  EditDialog(this.title, this.name, this.value, this.onSubmit, {super.key}) {
    textEditingController.text = value;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: name,
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 关闭弹窗
          },
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            onSubmit(textEditingController.text);
            Navigator.of(context).pop(); // 关闭弹窗
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}
