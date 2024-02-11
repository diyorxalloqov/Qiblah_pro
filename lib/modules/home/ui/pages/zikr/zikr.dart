import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class ZikrMain extends StatelessWidget {
  const ZikrMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, "ertalabki_zikrlar".tr()),
      body: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (context, index) {
            if (index == 0) {
              return const ZikrItem(index: 1);
            } else {
              return ZikrItem(index: index + 1);
            }
          }),
    );
  }
}

class ZikrItem extends StatelessWidget {
  final int index;
  const ZikrItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'tasbehPage');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
            color: containerColor, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r))),
                  child: Text(
                    '$index',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SmallText(text: 'Bugun: 33 Jami: 500')
              ],
            ),
            const SpaceHeight(),
            const MediumText(
                text: 'Lorem Ipsum is simply dummy text of the printing'),
            const SpaceHeight(),
            const SmallText(
                text: 'Lorem Ipsum is simply dummy text of the printing'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                IconButton(
                    onPressed: () {}, icon: SvgPicture.asset(AppIcon.bookmark))
              ],
            )
          ],
        ),
      ),
    );
  }
}
