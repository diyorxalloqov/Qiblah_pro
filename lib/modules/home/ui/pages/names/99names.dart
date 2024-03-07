import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesPage extends StatefulWidget {
  const NamesPage({super.key});

  @override
  State<NamesPage> createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  late NamesBloc namesBloc;
  @override
  void initState() {
    namesBloc = NamesBloc();
    super.initState();
  }

  @override
  void dispose() {
    namesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'ficha_99_names'.tr()),
      body: BlocProvider.value(
        value: namesBloc,
        child: BlocBuilder<NamesBloc, NamesState>(
          builder: (context, state) {
            print(state.status);
            if (state.status == ActionStatus.isLoading) {
              return const LoadingPage();
            }
            if (state.status == ActionStatus.isSuccess) {
              return RefreshIndicator.adaptive(
                onRefresh: () {
                  final completer = Completer<void>();
                  namesBloc.add(GetNamesEvent());
                  completer.complete();
                  return completer.future;
                },
                child: ListView.builder(
                    itemCount: state.namesModel.length,
                    itemBuilder: (context, index) => CardItem1(
                        index: index, namesBloc: namesBloc, state: state)),
              );
            }
            return RefreshIndicator.adaptive(
                onRefresh: () {
                  final completer = Completer<void>();
                  namesBloc.add(GetNamesFromApiEvent());
                  completer.complete();
                  return completer.future;
                },
                child: ListView(
                  children: [
                    SizedBox(height: context.height * 0.3),
                    Center(child: Text(state.error)),
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class CardItem1 extends StatelessWidget {
  final int index;
  final NamesState state;
  final NamesBloc namesBloc;
  const CardItem1(
      {super.key,
      required this.index,
      required this.namesBloc,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        onTap: () {
          Navigator.of(context).pushNamed('namesDetailsPage',
              arguments:
                  NamesDetailsArgument(namesBloc: namesBloc, index: index));
        },
        leading: Container(
          width: 28,
          height: 28,
          decoration: ShapeDecoration(
            color: primaryColor,
            shape: const StarBorder(points: 8, innerRadiusRatio: 0.84),
          ),
          child: Center(
              child: Text(
            '${index + 1}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: AppFontWeight.w_500),
          )),
        ),
        title: Text(
          state.namesModel[index].title.toString(),
          style: TextStyle(
            fontSize: AppSizes.size_16,
            color: context.isDark ? Colors.white : Colors.black,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
        subtitle: Text(
          state.namesModel[index].translation.toString(),
          style: TextStyle(
              color: smallTextColor,
              fontSize: AppSizes.size_12,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_400),
        ),
        trailing: Text(
          state.namesModel[index].nameArabic.toString(),
          style: TextStyle(
            color: context.isDark ? arabicWhiteTextColor : arabicTextColor,
            fontSize: AppSizes.size_24,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
      ),
    );
  }
}
