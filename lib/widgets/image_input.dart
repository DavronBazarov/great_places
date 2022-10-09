import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  Function onSelectImage;
   ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _takePicture() async {
    final imageFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage?.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            width: 170,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xffD5DDE0),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            alignment: Alignment.center,
            child: _storedImage != null
                ? Image.file(
              _storedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
            )
                : const Text(
              'No Image Taken',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        color:Color(0xffAB47BC),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _takePicture,
                    icon: const Icon(Icons.camera),
                    label: const Text('Take Picture'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
