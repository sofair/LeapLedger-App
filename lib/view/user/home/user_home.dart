import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 页面内容
          Container(
            color: Colors.white, // 页面右侧为白色
            child: const Center(
              child: Text(
                '页面内容',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          // 阴影部分
          GestureDetector(
              onTap: () {
                // 在点击阴影部分时关闭页面
                Navigator.of(context).pop();
              },
              child: Opacity(
                opacity: 0.5, // 设置透明度，0.0 表示完全透明，1.0 表示完全不透明
                child: Container(
                  width: 100,
                  color: Colors.grey.withOpacity(0.1), // 半透明的黑色阴影
                ),
              )),
        ],
      ),
    );
  }
}
