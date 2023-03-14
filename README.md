# Camera Gallery Image Picker

A Flutter package that provides a simple and customizable way to capture images from the camera and pick image from gallery and both from camera and gallery at a same time.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  camera_gallery_image_picker: ^0.0.1
```

Then, run `flutter pub get` to install the package.

## IOS
Add following keys to your `info.plist` file:

```
 <key>NSCameraUsageDescription</key>
 <string>Describe why yo need camera permission</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>Describe why you need photo library permission</string>
```

## Android
No any configuration is required.

## Usage
Import the package:
```
import 'package:camera_gallery_image_picker/camera_gallery_image_picker.dart';
```


## Screenshots
<img src="https://github.com/Hpaneru/camera_gallery_image_picker/raw/feature/multi-image-picker/screenshots/1.png" height="300cm"/>
<img src="https://github.com/Hpaneru/camera_gallery_image_picker/raw/feature/multi-image-picker/screenshots/2.png" height="300cm"/>

## Example
```
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
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.CAMERA,
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
                  source: ImagePickerSource.GALLERY,
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
                  source: ImagePickerSource.BOTH,
                );
                setState(() {});
              },
              child: const Text(
                'Pick Image from Both',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```