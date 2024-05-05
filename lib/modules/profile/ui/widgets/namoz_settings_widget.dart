import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamozSettingsWidget<T extends Enum> extends StatelessWidget {
  final List<T> choices;

  const NamozSettingsWidget({super.key, required this.choices});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NamozTimeBloc, NamozTimeState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: choices.length,
          itemBuilder: (context, index) {
            var choice = choices[index];
            return ListTile(
              title: Text(
                choice.name,
                style: TextStyle(
                    color: context.isDark ? Colors.white : Colors.black,
                    fontFamily: AppfontFamily.inter.fontFamily),
              ),
              onTap: () {
                context
                    .read<NamozTimeBloc>()
                    .add(ChangeSettings(newValue: choice));
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
