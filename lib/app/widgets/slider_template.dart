import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';

class SliderTemplate extends StatelessWidget {
  String label;
  ValueChanged<double> onChangeSlider;
  double maxSlider;
  double minSlider;
  double value;
  Color? color;
  SliderTemplate({Key? key, required this.label, required this.onChangeSlider, required this.maxSlider, required this.minSlider, required this.value, this.color}) : super(key: key);

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
             ),
             textAlign: TextAlign.right,
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
              onChanged:(value)=> onChangeSlider(value), 
              activeColor: color ?? secondColor,
           ),
         ),
       ],
     );
  }
}