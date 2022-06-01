import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';

class SmallButton extends StatelessWidget {
  String label;
  Function onTap;
  SmallButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthP(context) / 4,
      height: sizePersen(context, 10.0),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(2)
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)
        ),
        onPressed: ()=>onTap(), 
        child: Text(label,style: const TextStyle(
          color: primaryColor,
          letterSpacing: 0.5
        ))
      )
    );
  }
}