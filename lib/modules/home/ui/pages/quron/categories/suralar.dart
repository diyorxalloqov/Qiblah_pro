import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/utils/extension/theme.dart';

class SuralarlarPage extends StatelessWidget {
  const SuralarlarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 114,
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
      // color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        onTap: () {
          Navigator.pushNamed(context, 'suralarDetails',
              arguments: SuralarDetailsPageArguments(
                  suraName: 'Al-Fotixa', index: index, suradata: 'suradata'));
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
          'Al - Fotixa',
          style: TextStyle(
            color: context.isDark ? Colors.white : Colors.black,
            fontSize: AppSizes.size_16,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
        subtitle: Text(
          'Lorem ipsum, 234 oyat',
          style: TextStyle(
              color: context.isDark ? const Color(0xffE3E7EA) : smallTextColor,
              fontSize: AppSizes.size_12,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_400),
        ),
        trailing: Text(
          'الفاتحة',
          style: TextStyle(
            color: context.isDark ? const Color(0xffE3E7EA) : arabicTextColor,
            fontSize: AppSizes.size_24,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
      ),
    );
  }
}
