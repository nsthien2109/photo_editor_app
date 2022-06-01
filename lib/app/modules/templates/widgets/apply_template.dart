import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/data/models/template.dart';
import 'package:photo_editor_pro/app/modules/editor/widget/filter_screen.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_editor_pro/app/widgets/big_button.dart';
import 'package:provider/provider.dart';

class ApplyTemplate extends StatefulWidget {
  TemplateModel template;
  ApplyTemplate({required this.template});

  @override
  State<ApplyTemplate> createState() => _ApplyTemplateState();
}

class _ApplyTemplateState extends State<ApplyTemplate> {
    void onChangeAll(){
      Provider.of<HomeProvider>(context, listen: false).onChangeSliderTemplate(
        widget.template.brightness!.toDouble(), 
        widget.template.contrast!.toDouble(), 
        widget.template.saturation!.toDouble(), 
        widget.template.red!.toInt(), 
        widget.template.green!.toInt(), 
        widget.template.blue!.toInt()
    );
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: primaryColor
        ),
        elevation: 0,
        backgroundColor: secondColor,
        actions: [
          IconButton(
            onPressed: ()=>context.read<HomeProvider>().onSaveImageToDevice(context), 
            icon: const Icon(Ionicons.checkmark)
          )
        ],
      ),
      body: SizedBox(
        height: heightP(context),
        child: Stack(
          children : [
          filterShow(),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: widthP(context),
              child: BigButton(
                label: "Áp dụng", onTap: onChangeAll
                ),
            )
            )  
          ]
      )
      ),
    );
  }
  Widget filterShow() { 
    return FilteredImageWidget(
      filter: context.watch<HomeProvider>().filter,
      image : context.watch<HomeProvider>().image,
      successBuilder: (imageBytes) 
          {
            context.read<HomeProvider>().saveTermImageBytes(imageBytes);
            return Container(
              height: heightP(context)/1.2,
              width: widthP(context),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: .4
                  )
                )
              ),
              child: Image.memory(imageBytes)
            );
          },
      errorBuilder: () => Container(),
    );
  }
}