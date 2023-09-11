part of 'common.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  const CommonCard(this.child, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(5),
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }
}
