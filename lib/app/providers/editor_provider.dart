import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class EditorProvider extends ChangeNotifier{
 
  Future<void> cropImage(context) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: Provider.of<HomeProvider>(context, listen: false).imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        
        androidUiSettings: const AndroidUiSettings(    
            backgroundColor: secondColor,
            toolbarColor: secondColor,
            toolbarWidgetColor: primaryColor,
            activeControlsWidgetColor: Colors.pinkAccent,
            statusBarColor: secondColor,
            cropFrameColor: Colors.green,
            toolbarTitle: "Cắt",
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Cắt',
        ));
    if (croppedFile != null)  {
      Provider.of<HomeProvider>(context, listen: false).croppedImage(croppedFile);
      notifyListeners();
    }
  }
}