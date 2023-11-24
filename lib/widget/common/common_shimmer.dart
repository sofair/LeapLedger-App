part of 'common.dart';

Widget buildShimmer() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade200, // 修改颜色为浅灰色
          highlightColor: Colors.grey.shade100,

          child: Container(
            width: 250.0, // 调整宽度
            height: 20.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16.0),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade200, // 修改颜色为浅灰色
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 350.0, // 调整宽度
            height: 16.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8.0), // 添加更多占位元素
        Shimmer.fromColors(
          baseColor: Colors.grey.shade200, // 修改颜色为浅灰色
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 200.0,
            height: 12.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget buildShimmerList() {
  return ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemCount: 10, // 重复渲染10次，可以根据需要调整
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 200.0,
              height: 20.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 300.0,
              height: 16.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32.0), // 调整需要的间距
        ],
      );
    },
  );
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10, // 重复渲染10次，可以根据需要调整
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 200.0,
                height: 20.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 300.0,
                height: 16.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32.0), // 调整需要的间距
          ],
        );
      },
    );
  }
}
