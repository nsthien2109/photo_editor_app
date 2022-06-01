// import 'package:flutter/material.dart';

// class ColorSizeSlider extends StatelessWidget {
//   const ColorSizeSlider({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return                                 Row(
//                                   children: [
//                                     const Expanded(
//                                     flex: 1, child: Text("Kích thước",style: TextStyle(
//                                       color: Colors.white
//                                     ))),
//                                     Expanded(
//                                       flex: 3,
//                                       child: Slider.adaptive(
//                                           min: 2,
//                                           max: 25,
//                                           value: controller.freeStyleStrokeWidth,
//                                           onChanged: setFreeStyleStrokeWidth),
//                                     ),
//                                   ],
//                                 ),
//                                 if (controller.freeStyleMode ==
//                                     FreeStyleMode.draw)
//                                   Row(
//                                     children: [
//                                       const Expanded(
//                                           flex: 1, child: Text("Màu sắc",style: TextStyle(
//                                       color: Colors.white
//                                     ))),
//                                       // Control free style color hue
//                                       Expanded(
//                                         flex: 3,
//                                         child: Slider.adaptive(
//                                             min: 0,
//                                             max: 359.99,
//                                             value: HSVColor.fromColor(
//                                                     controller.freeStyleColor)
//                                                 .hue,
//                                             activeColor:
//                                                 controller.freeStyleColor,
//                                             onChanged: setFreeStyleColor),
//                                       ),
//                                     ],
//                                   ),
//   }
// }