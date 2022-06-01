// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/data/models/template.dart';
import 'package:photo_editor_pro/app/modules/templates/widgets/apply_template.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class TemplateItem extends StatelessWidget {
  TemplateModel template;
  TemplateItem({Key? key, required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthP(context)/2,
      decoration: BoxDecoration(
        color: const Color(0xffffd7ccc8).withOpacity(.4),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7)
            ),
          ]
      ),
      child: Stack(
        children: [
          Center(child: Text(template.nameTemplate.toString())),
          Positioned(
            bottom: sizePersen(context, 2),
            child: Container(
              width: widthP(context)/2  - 10,
              padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(template.author.toString().toUpperCase()),
                  GestureDetector(
                    onTap: ()=>Provider.of<HomeProvider>(context, listen: false).getImageApplyTemplate(context, template),
                    child: Container(
                      padding: EdgeInsets.all(sizePersen(context, 1)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: .5)
                      ),
                      child: const Center(child: Icon(Ionicons.play))),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}