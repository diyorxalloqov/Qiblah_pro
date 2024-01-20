import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class ImagePickerWidget extends StatefulWidget {
  final VoidCallback imageOntap;
  final Bloc profileBloc;

  const ImagePickerWidget({
    super.key,
    required this.imageOntap,
    required this.profileBloc,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ImagePickerService.selectedImage != null
          ? Image.file(ImagePickerService.selectedImage!)
          : const SizedBox.shrink(),
      actions: [
        !isUploaded
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      widget.profileBloc.add(const PickImageEvent(
                          imageSource: ImageSource.camera));
                      setState(() {
                        isUploaded = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0.dg),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: const Column(
                        children: [Icon(Icons.camera), Text("Camera")],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      widget.profileBloc.add(const PickImageEvent(
                          imageSource: ImageSource.gallery));
                      setState(() {
                        isUploaded = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0.dg),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: const Column(
                        children: [Icon(Icons.image_outlined), Text("Galery")],
                      ),
                    ),
                  )
                ],
              )
            : ElevatedButton(
                onPressed: widget.imageOntap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: const Text(
                  "выбирать",
                  style: TextStyle(color: Colors.white),
                ))
      ],
    );
  }
}

class ImagePickerService {
  static ImageSource camera = ImageSource.camera;
  static ImageSource galery = ImageSource.gallery;

  static File? selectedImage;
  static XFile? image;

  static Future<void> pickImage(ImageSource source) async {
    try {
      image = await ImagePicker().pickImage(source: source);
      File? img = File(image!.path);
      selectedImage = img;
      await const FlutterSecureStorage()
          .write(key: Keys.image, value: selectedImage?.path ?? '');
    } catch (e) {
      debugPrint("Rasm yuklashda xatolik $e");
    }
  }
}
