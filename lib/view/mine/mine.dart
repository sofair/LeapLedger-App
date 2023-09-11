import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  Widget _navigationTitle(
      String name, IconData icon, Widget widget, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(width: 16.0),
              Text(
                '小M',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
        const Navigation()
      ],
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  Widget _navigationTitle(
      String name, IconData icon, Widget widget, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(children: [
          _navigationTitle('Widget1', Icons.favorite, Widget1(), context),
          const Divider(),
          _navigationTitle('Widget2', Icons.favorite, Widget2(), context),
        ]));
  }
}

class Widget1 extends StatelessWidget {
  const Widget1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Widget1"));
  }
}

class Widget2 extends StatelessWidget {
  const Widget2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Widget2"));
  }
}
