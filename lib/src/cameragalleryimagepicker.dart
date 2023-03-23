import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// ENUMS for ImagePickerSource
enum ImagePickerSource {
  both,
  camera,
  gallery,
}

class CameraGalleryImagePicker {
  /// PICK AN IMAGE FROM CAMERA OR GALLERY WHICH RETURNS A [File] IMAGE
  static Future pickImage({
    double? maxWidth,
    double? maxHeight,
    Widget? cameraText,
    Widget? closeWidget,
    Widget? galleryText,
    Widget? cameraWidget,
    Widget? galleryWidget,
    int? cameraImageQuality,
    int? galleryImageQuality,
    bool enableCloseButton = true,
    bool barrierDismissible = false,
    required BuildContext context,
    required ImagePickerSource source,
  }) async {
    assert((galleryImageQuality == null ||
            (galleryImageQuality >= 0 && galleryImageQuality <= 100)) ||
        (cameraImageQuality == null ||
            (cameraImageQuality >= 0 && cameraImageQuality <= 100)));

    if (maxWidth != null && maxWidth < 0) {
      throw ArgumentError.value(maxWidth, 'maxWidth cannot be negative');
    }

    if (maxHeight != null && maxHeight < 0) {
      throw ArgumentError.value(maxHeight, 'maxHeight cannot be negative');
    }

    /// PICK IMAGE FROM GALLERY AND RETURN A [File] IMAGE
    Future<File?>? pickImageFromGallery() async {
      XFile? pickedImage = await ImagePicker().pickImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        source: ImageSource.gallery,
        imageQuality: cameraImageQuality,
      );
      return pickedImage == null ? null : File(pickedImage.path);
    }

    /// PICK IMAGE FROM CAMERA AND RETURN A [File] IMAGE
    Future<File?>? captureImageFromCamera() async {
      XFile? capturedImage = await ImagePicker().pickImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        source: ImageSource.camera,
        imageQuality: galleryImageQuality,
      );
      return capturedImage == null ? null : File(capturedImage.path);
    }

    /// SOURCE FOR IMAGE PICKER
    switch (source) {
      case ImagePickerSource.camera:
        return captureImageFromCamera();
      case ImagePickerSource.gallery:
        return pickImageFromGallery();
      case ImagePickerSource.both:
        return showDialog<void>(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (enableCloseButton)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: closeWidget ??
                            const Icon(
                              Icons.close,
                              size: 14,
                            ),
                      ),
                    ),
                  InkWell(
                    onTap: () async {
                      File? capturedImage = await captureImageFromCamera();
                      if (context.mounted) {
                        Navigator.pop(context, capturedImage);
                      }
                    },
                    child: ListTile(
                      title: cameraText ?? const Text("Camera"),
                      leading: cameraWidget ??
                          const Icon(
                            Icons.camera,
                            color: Colors.black,
                          ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () async {
                      File? pickedImage = await pickImageFromGallery();
                      if (context.mounted) {
                        Navigator.pop(context, pickedImage);
                      }
                    },
                    child: ListTile(
                      title: galleryText ?? const Text("Gallery"),
                      leading: galleryWidget ??
                          const Icon(
                            Icons.image,
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
    }
  }

  /// PICK MULTIPLE IMAGES FROM GALLERY WHICH RETURNS A LIST OF [File] IMAGE
  static Future<List<File>> pickMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    assert(imageQuality == null || (imageQuality >= 0 && imageQuality <= 100));

    if (maxWidth != null && maxWidth < 0) {
      throw ArgumentError.value(maxWidth, 'maxWidth cannot be negative');
    }

    if (maxHeight != null && maxHeight < 0) {
      throw ArgumentError.value(maxHeight, 'maxHeight cannot be negative');
    }

    /// PICK MULTIPLE IMAGES FROM GALLERY AND RETURN A LIST OF [File] IMAGE
    List<XFile>? pickedMultipleImages = await ImagePicker().pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    return pickedMultipleImages.map((e) => File(e.path)).toList();
  }
}
