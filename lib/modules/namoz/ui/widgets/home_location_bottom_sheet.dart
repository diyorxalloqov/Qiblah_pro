import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

showHomeLocationBottomSheet(BuildContext c) {
  showModalBottomSheet(
    isDismissible: false,
    context: c,
    isScrollControlled: true,
    builder: (c) => const HomeLocationBottomSheet(),
  );
}

class HomeLocationBottomSheet extends StatefulWidget {
  const HomeLocationBottomSheet({Key? key}) : super(key: key);

  @override
  State<HomeLocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<HomeLocationBottomSheet> {
  late TextEditingController _controller;
  String searchText = '';
  List<String> allLocations = [
    "Toshkent",
    "Buxoro",
    "Andijon",
    "Farg'ona",
    "Namangan",
    "Samarqand",
    "Navoiy",
    "Sirdaryo",
    "Surxandaryo",
    "Qashqadaryo",
    "Qarshi"
  ];
  List<String> filteredLocations = [];

  void updateSearch(String text) {
    setState(() {
      searchText = text.toLowerCase();

      filteredLocations = allLocations
          .where((location) => location.toLowerCase().startsWith(searchText))
          .toList();
    });
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: MediumText(text: 'manzilni_qidirish'.tr()),
        ),
        Container(
          height: context.height * .7,
          color: scaffoldColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
            child: Column(
              children: [
                TextFormField(
                  controller: _controller,
                  onChanged: updateSearch,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: smallTextColor,
                      ),
                      hintText: 'manzil'.tr(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 0.5))),
                ),
                const SpaceHeight(),
                Expanded(
                    child: filteredLocations.isEmpty
                        ? Center(
                            child: Text(_controller.text.isEmpty
                                ? ''
                                : "Hech qanday natija topilmadi".tr()),
                          )
                        : ListView.builder(
                            itemCount: filteredLocations.length,
                            padding: const EdgeInsets.all(10.0),
                            itemBuilder: (context, index) {
                              final itemIndex = filteredLocations[index];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcon.location,
                                        width: 24.w,
                                        color: smallTextColor,
                                      ),
                                      const SpaceWidth(),
                                      Text(
                                        itemIndex,
                                        style: const TextStyle(
                                          fontSize: AppSizes.size_16,
                                          fontWeight: AppFontWeight.w_400,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SpaceHeight(),
                                  const Divider()
                                ],
                              );
                            }))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
