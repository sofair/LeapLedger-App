import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(
    BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('确认删除？'),
        content: const Text('你确定要删除吗？'),
        actions: [
          TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
            child: const Text('确认'),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
