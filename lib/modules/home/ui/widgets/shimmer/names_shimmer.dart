import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:shimmer/shimmer.dart';

class NamesShimmer extends StatelessWidget {
  const NamesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 99,
            itemBuilder: (context, index) {
              return CardItem1(index: index);
            }));
  }
}

class CardItem1 extends StatelessWidget {
  final int index;
  const CardItem1({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.white30,
        enabled: true,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
          ),
        ));
  }
}
