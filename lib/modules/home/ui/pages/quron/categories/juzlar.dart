import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/utils/extension/theme.dart';

class JuzlarPage extends StatelessWidget {
  const JuzlarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 99,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const CardItem(index: 1);
          } else {
            return CardItem(index: index + 1);
          }
        });
  }
}

class CardItem extends StatelessWidget {
  final int index;
  const CardItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, 'juzlarDetails',
              arguments: JuzlarDetailsArgument(
                  suraName: '$index - Juz',
                  index: index,
                  suradata: 'suradata'));
        },
        leading: Container(
          width: 28,
          height: 28,
          decoration: ShapeDecoration(
            color: primaryColor,
            shape: const StarBorder(
              points: 8,
              innerRadiusRatio: 0.84,
            ),
          ),
          child: Center(
              child: Text(
            '$index',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: AppFontWeight.w_500),
          )),
        ),
        title: Text(
          '1-Juz',
          style: TextStyle(
            color: context.isDark ? Colors.white : Colors.black,
            fontSize: AppSizes.size_16,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
        subtitle: Text(
          '1-20 sahifalar',
          style: TextStyle(
              color: context.isDark ? const Color(0xffE3E7EA) : smallTextColor,
              fontSize: AppSizes.size_12,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_400),
        ),
      ),
    );
  }
}
