part of '../navigation.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.key),
            title: const Text('修改密码'),
            contentPadding: const EdgeInsets.only(left: 48),
            onTap: () {
              Navigator.pushNamed(context, UserRoutes.passwordUpdate);
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('账本管理'),
            contentPadding: const EdgeInsets.only(left: 48),
            onTap: () {
              Navigator.pushNamed(context, AccountRoutes.list);
            },
          ),
          ListTile(
            leading: const Icon(Icons.toggle_on_outlined),
            title: const Text('分享配置'),
            contentPadding: const EdgeInsets.only(left: 48),
            onTap: () {
              Navigator.pushNamed(context, UserRoutes.configTransactionShare);
            },
          ),
        ],
      ),
    );
  }
}
