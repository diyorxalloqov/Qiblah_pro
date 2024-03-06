import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class ImagePickerWidget extends StatefulWidget {
  final ProfileBloc profileBloc;
  const ImagePickerWidget({super.key, required this.profileBloc});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            widget.profileBloc
                .add(const PickImageEvent(source: ImageSource.camera));
            Navigator.pop(context);
          },
          child: Container(
            height: 80,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Column(
              children: [Icon(Icons.camera), Text("Camera")],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.profileBloc
                .add(const PickImageEvent(source: ImageSource.gallery));
            Navigator.pop(context);
          },
          child: Container(
            height: 80,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Column(
              children: [Icon(Icons.image_outlined), Text("Gallery")],
            ),
          ),
        )
      ],
    ));
  }
}
