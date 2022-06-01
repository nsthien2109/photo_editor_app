import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_editor_pro/app/widgets/choose_image_button.dart';
import 'package:provider/provider.dart';

class ChooseImageSource extends StatelessWidget {
  const ChooseImageSource({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 5)),
      width: widthP(context),
      height: widthP(context)/4,
      child: Row(
        children: [
          ChooseImageButton(title: "Camera", icon: Ionicons.camera_outline, color: Colors.teal[200]!, onTap: ()=> Provider.of<HomeProvider>(context, listen: false).getFromCamera(context)),
          SizedBox(width: sizePersen(context, 3)),
          ChooseImageButton(title: "Gallery", icon: Ionicons.image_outline, color: Colors.orange[200]!, onTap: ()=>Provider.of<HomeProvider>(context, listen:  false).getFromGallery(context)),
        ],
      ),
    );
  }
}