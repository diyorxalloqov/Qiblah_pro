import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class JuzlarPage extends StatefulWidget {
  const JuzlarPage({super.key});

  @override
  State<JuzlarPage> createState() => _JuzlarPageState();
}

class _JuzlarPageState extends State<JuzlarPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 30,
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
          context.read<QuronBloc>().add(GetJuzFromDb(index: index));
          Navigator.pushNamed(context, 'juzlarDetails',
              arguments: JuzlarDetailsArgument(
                  suraName: '$index - Juz', index: index));
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
          '$index - Juz',
          style: TextStyle(
            color: context.isDark ? Colors.white : Colors.black,
            fontSize: AppSizes.size_16,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
      ),
    );
  }
}
