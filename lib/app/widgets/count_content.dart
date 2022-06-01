import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';

class CountContent extends StatelessWidget {
  int counter;
  String label;
  CountContent({required this.counter, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(counter.toString(),style: TextStyle(
            fontSize: sizeText(context, 15)
          )
        ),
        SizedBox(width: sizePersen(context, 1.5)),
        Text(label,style: TextStyle(
            fontSize: sizeText(context, 10),
            color: lightGrey
          )
        )
      ],
    );
  }
}