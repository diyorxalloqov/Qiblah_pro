import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SavedZikrs extends StatefulWidget {
  final ZikrBloc zikrBloc;
  const SavedZikrs({super.key, required this.zikrBloc});

  @override
  State<SavedZikrs> createState() => _SavedZikrsState();
}

class _SavedZikrsState extends State<SavedZikrs> {
  @override
  void initState() {
    widget.zikrBloc.add(GetSavedZikrsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'zikr'.tr()),
      body: BlocBuilder<ZikrBloc, ZikrState>(
        bloc: widget.zikrBloc,
        builder: (context, state) {
          if (state.savedZikrStatus == ActionStatus.isLoading) {
            return const LoadingPage();
          }
          if (state.savedZikrStatus == ActionStatus.isSuccess) {
            return ListView.builder(
                itemCount: state.savedZikrs.length,
                itemBuilder: (context, index) {
                  return ZikrItem(
                    categoryId: '0',
                      index: index, zikrBloc: widget.zikrBloc, state: state);
                });
          } else if (state.savedZikrStatus == ActionStatus.isError) {
            return Center(
              child: Text(
                'empty_zikrs'.tr(),
                style: TextStyle(
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontWeight: AppFontWeight.w_500,
                    fontSize: AppSizes.size_16),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
