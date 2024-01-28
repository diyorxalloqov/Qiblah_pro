import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class AllFunctionPage extends StatelessWidget {
  const AllFunctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, "barcha_funksiyalar".tr()),
      body: Column(
        children: [
          SpaceHeight(height: 12.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 28.w,
                      mainAxisSpacing: 18.h,
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 60.r,
                          width: 60.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: smallTextColor.withOpacity(0.1), width: 1),
                            color: Colors.red,
                          ),
                        ),
                        Text('data')
                      ],
                    );
                  }),
            ),
          ),
          // Expanded(
          //     child: GridView.builder(
          //         itemCount: 20,
          //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 4),
          //         itemBuilder: (context, index) {
          //           return CircleAvatar();
          //         }))
        ],
      ),
    );
  }
}
