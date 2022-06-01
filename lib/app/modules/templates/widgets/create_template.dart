import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/modules/editor/widget/filter_screen.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_editor_pro/app/providers/template_provider.dart';
import 'package:photo_editor_pro/app/widgets/big_button.dart';
import 'package:photo_editor_pro/app/widgets/slider_template.dart';
import 'package:photo_editor_pro/app/widgets/small_button.dart';
import 'package:provider/provider.dart';

class CreateTemPlate extends StatefulWidget {
  const CreateTemPlate({ Key? key }) : super(key: key);

  @override
  State<CreateTemPlate> createState() => _CreateTemPlateState();
}

class _CreateTemPlateState extends State<CreateTemPlate> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  double brightness = 0;
  double contrast = 0;
  double staturation  = 0;
  double red = 0;
  double green = 0;
  double blue = 0;

  void reset(){
    setState(() {
      brightness = 0;
      contrast = 0;
      staturation  = 0;
      red = 0;
      green = 0;
      blue = 0;
    });
  }

  void onChangeBrightness(value){
    setState(() {
      brightness = value;
    });
    onChangeAll();
  }

  void onChangeContrast(value){
    setState(() {
      contrast = value;
    });
    onChangeAll();
  }

  void onChangeStaturation(value){
    setState(() {
      staturation = value;
    });
    onChangeAll();
  }

  void onChangeRed(value){
    setState(() {
      red = value;
    });
    onChangeAll();
  }


  void onChangeGreen(value){
    setState(() {
      green = value;
    });
    onChangeAll();
  }

  void onChangeBlue(value){
    setState(() {
      blue = value;
    });
    onChangeAll();
  }

  void onChangeAll(){
      Provider.of<HomeProvider>(context, listen: false).onChangeSliderTemplate(
        brightness, 
        contrast, 
        staturation, 
        red.toInt(), 
        green.toInt(), 
        blue.toInt()
      );
  }

  void createTemplate() {
    User user = Provider.of<User>(context, listen: false);
    Provider.of<TemplateProvider>(context, listen:  false).createTemplate(
        nameController.text,
        brightness, 
        contrast, 
        staturation, 
        red,
        green,
        blue,
        user!= null ? user.displayName.toString() : "UNK",
        user!= null ? user.uid : "XYZ"
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: primaryColor
        ),
        title: const Text("Tạo template của chính bạn",style: TextStyle(
          color: primaryColor
        )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()=>reset(), 
            icon: const Icon(Ionicons.refresh_outline)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            filterShow(),
            SizedBox(height: sizePersen(context, 4)),
            SliderTemplate(
              label: "Độ sáng", 
              onChangeSlider: onChangeBrightness,
              maxSlider: 1, 
              minSlider: -1, 
              value: brightness
            ),
            SliderTemplate(
              label: "Tương phản", 
              onChangeSlider: onChangeContrast,
              maxSlider: 1, 
              minSlider: -1, 
              value: contrast
            ),
            SliderTemplate(
              label: "Bão hòa", 
              onChangeSlider: onChangeStaturation,
              maxSlider: 5, 
              minSlider: -1, 
              value: staturation
            ),
            const Divider(),
            SliderTemplate(
              label: "Đỏ", 
              onChangeSlider: onChangeRed,
              maxSlider: 255, 
              minSlider: 0, 
              value: red,
              color: Colors.red,
            ),
            SliderTemplate(
              label: "Xanh lá", 
              onChangeSlider: onChangeGreen,
              maxSlider: 255, 
              minSlider: 0, 
              value: green,
              color: Colors.green,
            ),
            SliderTemplate(
              label: "Xanh dương", 
              onChangeSlider: onChangeBlue,
              maxSlider: 255, 
              minSlider: 0, 
              value: blue,
              color: Colors.blue,
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.all(sizePersen(context, 5)),
              child: BigButton(label: "Tạo", onTap: ()=> showModalName(context)),
            )
          ],
        ),
      ),
    );
  }

    Widget filterShow() { 
    return FilteredImageWidget(
      filter: Provider.of<HomeProvider>(context, listen: false).filter,
      image : Provider.of<HomeProvider>(context, listen: false).image,
      successBuilder: (imageBytes) 
          {           
            return Container(
              height: heightP(context)/2,
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

    void showModalName(context){
    showModalBottomSheet(
      context: context, 
      builder: (_)=> Container(
        height: widthP(context)/1.8,
        padding: EdgeInsets.all(sizePersen(context, 10)),
        child: GestureDetector(
          child: SizedBox(
            height: 50,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (value) => value!.length >= 10 ? "Name must be less than 10 charactor" : value.isEmpty ? "Enter name filter pleaser" : null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondColor.withOpacity(.5),
                          width: .1
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondColor.withOpacity(.5),
                          width: .1
                        ),
                      ),
                      hintText: "Nhập tên template ... "
                    ),
                  ),
                  SizedBox(height: sizePersen(context, 4)),
                  SmallButton(label: "Tạo ngay", onTap: (){
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      try {
                        createTemplate();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tạo thành công')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tạo thất bại')),
                        );
                      }
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      )
    );
  }


}