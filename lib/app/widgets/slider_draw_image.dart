import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';

class SliderDrawImage extends StatelessWidget {
  PainterController controller;
  String label;
  ValueChanged<double> onChangeSlider;
  double maxSlider;
  double minSlider;
  double value;
  Color? color;
  SliderDrawImage({Key? key, required this.controller, required this.label, required this.onChangeSlider, required this.maxSlider, required this.minSlider, required this.value, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
       children: [
        Expanded(
          flex: 1, 
          child: Text(
            label,
            style: const TextStyle(
               color: primaryColor
             )
          )
        ),
        Expanded(
          flex: 3,
          child: Slider.adaptive(
            thumbColor: primaryColor,
            inactiveColor: lightGrey,           
              min: minSlider,
              max: maxSlider,
              value: value,
              onChanged: onChangeSlider, 
              activeColor: color ?? primaryColor,
           ),
         ),
       ],
     );
  }
}