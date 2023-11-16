part of '../navigation.dart';

class UserDrawerHeader extends StatefulWidget {
  const UserDrawerHeader({super.key});

  @override
  State<UserDrawerHeader> createState() => _UserDrawerHeaderState();
}

class _UserDrawerHeaderState extends State<UserDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
              backgroundImage: null,
              radius: 32.0,
              child: Icon(
                Icons.person,
                size: 32.0,
              )),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocListener<UserBloc, UserState>(
                    listener: (_, state) {
                      if (state is UserUpdateInfoSuccess) {
                        setState(() {});
                      }
                    },
                    child: buildUsername(context)),
                const SizedBox(height: 8.0),
                Text(
                  UserBloc.email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUsername(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onSubmit(String value) {
            UserInfoUpdateModel model = UserInfoUpdateModel();
            model.username = value;
            BlocProvider.of<UserBloc>(context).add(UserInfoUpdateEvent(model));
          }

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditDialog("编辑昵称", null, UserBloc.username, onSubmit);
              });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              UserBloc.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.edit_calendar,
              color: Colors.white,
              size: 18,
            ),
          ],
        ));
  }
}
