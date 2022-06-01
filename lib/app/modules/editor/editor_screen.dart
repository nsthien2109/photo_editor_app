// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/modules/editor/widget/bottom_sheet.dart';
import 'package:photo_editor_pro/app/modules/editor/widget/filter_screen.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class EditorScreen extends StatefulWidget {
  Uint8List byteImage;
  EditorScreen({required this.byteImage});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final heightBottom = widthP(context)/2;
    return Scaffold(
      backgroundColor: secondColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            splashRadius: .3,
            onPressed: ()=> context.read<HomeProvider>().onSaveImageToDevice(context), 
            icon: const Icon(Ionicons.arrow_down_outline)
          )
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, control , _) => Container(
        alignment: Alignment.center,
          height: heightP(context) - heightBottom,
          child:  buildWidget(context,control)
        ),
      ),
      bottomSheet: BottomEditor(byteImage: widget.byteImage)
    );
  }

  Widget buildWidget(context, control){
    if(control.filterMode || control.effectMode || control.colorEdit || control.contrastEdit || control.brightnessEdit || control.saturationEdit || control.sepiaEdit || control.greyScaleEdit || control.invertEdit){
      return filterShow();
    }else{
      return PhotoView(
        backgroundDecoration: const BoxDecoration(
          color: secondColor
        ),
        basePosition: Alignment.center,
         minScale: .21,
        initialScale: .3,
        imageProvider: MemoryImage(Provider.of<HomeProvider>(context, listen: false).bytesImage),
          filterQuality: FilterQuality.high,
      );
    }
  }
  
  Widget filterShow() { 
    return FilteredImageWidget(
      filter: Provider.of<HomeProvider>(context, listen: false).filter,
      image : Provider.of<HomeProvider>(context, listen: false).image,
      successBuilder: (imageBytes) 
          {           
            context.read<HomeProvider>().saveTermImageBytes(imageBytes);
            return PhotoView(
              backgroundDecoration: const BoxDecoration(
              color: secondColor
            ),
              disableGestures: false,
              basePosition: Alignment.center,
              minScale: .21,
              initialScale: .67,
              imageProvider: MemoryImage(context.watch<HomeProvider>().bytesImageTerm),
              filterQuality: FilterQuality.low,
            );
          },
      errorBuilder: () => Container(),
    );
  }

}

