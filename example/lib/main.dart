import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera_gallery_image_picker/camera_gallery_image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Camera Gallery Image Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CameraGalleryImagePickerExample(),
    );
  }
}

class CameraGalleryImagePickerExample extends StatefulWidget {
  const CameraGalleryImagePickerExample({super.key});

  @override
  State<CameraGalleryImagePickerExample> createState() =>
      _CameraGalleryImagePickerState();
}

class _CameraGalleryImagePickerState
    extends State<CameraGalleryImagePickerExample> {
  File? _imageFile;
  List<File> _multipleImageFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null) ...[
              Image.file(
                _imageFile!,
                height: 200,
              ),
              const SizedBox(height: 20)
            ],
            if (_multipleImageFiles.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _multipleImageFiles
                      .map(
                        (File file) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            file,
                            height: 100,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20)
            ],
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.camera,
                );
                setState(() {});
              },
              child: const Text(
                'Capture Image from Camera',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.gallery,
                );
                setState(() {});
              },
              child: const Text(
                'Pick Image from Gallery',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.both,
                );
                setState(() {});
              },
              child: const Text(
                'Pick Image from Both',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _multipleImageFiles =
                    await CameraGalleryImagePicker.pickMultiImage();
                setState(() {});
              },
              child: const Text(
                'Pick Multiple Images',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
