// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/data/models/editor_mode.dart';
import 'package:photo_editor_pro/app/modules/editor/widget/slider.dart';
import 'package:photo_editor_pro/app/providers/editor_provider.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photofilters/photofilters.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/effect_array.dart';

class BottomEditor extends StatefulWidget {
  Uint8List byteImage;
  BottomEditor({required this.byteImage});

  @override
  State<BottomEditor> createState() => _BottomEditorState();
}

class _BottomEditorState extends State<BottomEditor> {

  int modeSelected = 1;
  int childEditors = 0;
  int filterSelect = 0;
  int effectSelect = 0;

  // list editor mode
  final editor_modes = [
    EditorMode(name: "Bộ lọc", editors: [...presetFiltersList]),
    EditorMode(name: "Điều chỉnh", editors: [
      EditorMode(name: "Cắt", icon: Ionicons.crop, onTap: (context)=> Provider.of<EditorProvider>(context, listen: false).cropImage(context)),
      EditorMode(name: "Màu sắc", icon: Ionicons.color_fill_outline),
      EditorMode(name: "Tương phản", icon: Ionicons.contrast_outline),
      EditorMode(name: "Độ sáng", icon: Ionicons.sunny_outline),
      EditorMode(name: "Bão hòa", icon: Ionicons.medical_outline),
      EditorMode(name: "Nâu đỏ", icon: Ionicons.water_outline),
      EditorMode(name: "Làm cũ", icon: Ionicons.timer_outline,onTap: (context)=> Provider.of<HomeProvider>(context, listen: false).onGreyScale()),
      EditorMode(name: "Đảo màu", icon: Ionicons.infinite_outline,onTap: (context)=> Provider.of<HomeProvider>(context, listen: false).onInvert()),
      EditorMode(name: "Test", icon: Ionicons.telescope)

    ]),
    EditorMode(name: "Hiệu ứng", editors: [...effectCustom]),
    EditorMode(name: "Văn bản", editors: []),
  ];


  @override
  Widget build(BuildContext context) {
    final heightBottomA =  widthP(context)/1.4;
    final heightBottomB = widthP(context)/2;
    return Container(
      width: widthP(context),
      height: context.watch<HomeProvider>().incrementHeightBottom ? heightBottomA : heightBottomB,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(
            padding: EdgeInsets.only(top: sizePersen(context, 3)),
            margin: context.watch<HomeProvider>().incrementHeightBottom == false ? EdgeInsets.only(bottom: sizePersen(context, 5)) : null,
            height: context.watch<HomeProvider>().incrementHeightBottom ? 4/5 * heightBottomB : 1/5 * heightBottomB,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               context.watch<HomeProvider>().needSave ? const Icon(Ionicons.close_outline, color: Colors.white) : const SizedBox(),
               context.watch<HomeProvider>().needChangeSlider ? const  SliderEdit() : const SizedBox(),
               context.watch<HomeProvider>().needSave ? GestureDetector(onTap: ()=> context.read<HomeProvider>().onSaveStateImage(context),child: const Icon(Ionicons.checkmark_outline,color: Colors.white)) : const SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: 1.5/5 * heightBottomA,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                ...editor_modes[modeSelected].editors!.map((e) => buildChildContent(context, heightBottomB, e)
                )
              ],
            ),
           ),
          SizedBox(
            height: 1/5 * heightBottomB,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 ...editor_modes.map((e) => GestureDetector(
                   onTap: (){
                     Provider.of<HomeProvider>(context, listen: false).setParentMode(context, editor_modes.indexOf(e));
                     setState(() {
                       modeSelected = editor_modes.indexOf(e);
                     });
                   },
                   child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 3)),
                     child: Center(
                       child: Text(e.name,style: TextStyle(
                         color: modeSelected == editor_modes.indexOf(e) ? Colors.pinkAccent : Colors.white,
                         fontSize: sizeText(context, 12)
                       )),
                     ),
                   ),
                 ))
               ],
             ),
          )
        ],
       ),
    );
  }
 
  builFilterList(BuildContext context, height, image, filter){
    return GestureDetector(
      onTap: () {
        context.read<HomeProvider>().changeFilters(filter);
        setState(() {
          filterSelect = presetFiltersList.indexOf(filter);
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: widthP(context)/6,
        margin: EdgeInsets.only(right: sizePersen(context, 3)),
        child: Stack(
          children: [
             SizedBox(
               width: widthP(context)/6,
               child: Image.memory(Provider.of<HomeProvider>(context, listen: false).bytesImage,fit: BoxFit.cover)
              ),
             Positioned(
               bottom: 0.0,
               child: Container(
                 width: widthP(context)/6,
                 decoration: BoxDecoration(
                   color: filterSelect == presetFiltersList.indexOf(filter) ? Colors.green[200] : Colors.pink[100]!,
                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))
                 ),
                 child: Text(
                   filter.name, 
                   textAlign: TextAlign.center, 
                   overflow: TextOverflow.ellipsis,
                   style: const TextStyle(
                     color: Colors.white
                   )
                  )
                )
            )
          ],
        ),
      ),
    );
  }


  buildEffectList(BuildContext context, height, image, effect){
    return GestureDetector(
      onTap: () {
        setState(() {
          effectSelect = effectCustom.indexOf(effect);
        });
        context.read<HomeProvider>().changeFilters(effect);
      },
      child: Tooltip(
        preferBelow: false,
        message: effect.name,
        child: Container(
          alignment: Alignment.center,
          width: widthP(context)/6,
          height: height,
          margin: EdgeInsets.only(right: sizePersen(context, 3)),
          child: Stack(
            children: [
               SizedBox(
                 width: widthP(context)/6,
                 child: Image.memory(Provider.of<HomeProvider>(context, listen: false).bytesImage,fit: BoxFit.cover)
                ),
               Positioned(
                 bottom: 0.0,
                 child: Container(
                   width: widthP(context)/5.5,
                   decoration: BoxDecoration(
                     color:  effectSelect == effectCustom.indexOf(effect) ? Colors.indigo[500]! : Colors.pink[100]!,
                     borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))
                   ),
                   child: Text(
                     effect.name,
                     textAlign: TextAlign.center,
                     overflow: TextOverflow.ellipsis,
                     style: const TextStyle(
                       color: Colors.white
                     )
                    )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget buildChildContent(context, heightBottom, e){
    if(modeSelected == 0){
      return builFilterList(context, heightBottom , widget.byteImage , e);
    }
    if(modeSelected == 2){
      return buildEffectList(context, heightBottom, widget.byteImage, e);
    }
    return GestureDetector(
        onTap: (){
          e.onTap != null ?  e.onTap(context) : null;
          Provider.of<HomeProvider>(context, listen: false).setStateEditorMode();
          setState(() {
            childEditors = editor_modes[modeSelected].editors!.indexOf(e);
          });
          Provider.of<HomeProvider>(context, listen: false).setChildMode(childEditors);
        },
        child: AnimatedContainer(
          height: 3/5 * heightBottom,
          width: widthP(context) / 6,
           duration: const Duration(seconds: 2),
          curve: Curves.easeInOutBack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(e.icon, color: childEditors == editor_modes[modeSelected].editors!.indexOf(e) ?Colors.pinkAccent[200]! : Colors.white, size: sizeText(context, 20)),
               SizedBox(height: sizePersen(context, 3)),
              Text(e.name, style: TextStyle(
                   color: childEditors == editor_modes[modeSelected].editors!.indexOf(e) ?Colors.pinkAccent[200]! : Colors.white,
                   fontSize: sizeText(context, 10)
                 ),
                 textAlign: TextAlign.center,
               )
            ],
           ),
        ),
      );
    }
}