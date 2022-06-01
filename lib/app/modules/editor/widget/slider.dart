import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SliderEdit extends StatefulWidget {
  const SliderEdit({ Key? key }) : super(key: key);

  @override
  State<SliderEdit> createState() => _SliderEditState();
}

class _SliderEditState extends State<SliderEdit> {
  double _currentSliderValue = 0;
  double _red = 0;
  double _green = 0;
  double _blue = 0;


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
      width: widthP(context)/1.5,
      child: context.watch<HomeProvider>().incrementHeightBottom == true ? 
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Slider(
            value: _red,
            activeColor: Colors.red[500],
            max: context.watch<HomeProvider>().maxSlider,
            min: context.watch<HomeProvider>().minSlider,
            onChanged: (double value) {
            setState(() {
              _red = value;
            });
            Provider.of<HomeProvider>(context, listen: false).changeSlider(_red, _green, _blue);
          }),
          Slider(
            value: _green,
            activeColor: Colors.green[500],
            max: context.watch<HomeProvider>().maxSlider,
            min: context.watch<HomeProvider>().minSlider,
            onChanged: (double value) {
            setState(() {
              _green = value;
            });
            //print("GREEN : ${_green.toInt()}");
            Provider.of<HomeProvider>(context, listen: false).changeSlider(_red, _green, _blue);
          }),
          Slider(
            value: _blue,
            activeColor: Colors.blue[500],
            max: context.watch<HomeProvider>().maxSlider,
            min: context.watch<HomeProvider>().minSlider,
            onChanged: (double value) {
            setState(() {
              _blue = value;
            });
            Provider.of<HomeProvider>(context, listen: false).changeSlider(_red, _green, _blue);
          }),
        ],
      ) :  Slider(
        value: _currentSliderValue,
        activeColor: Colors.white,
        max: context.watch<HomeProvider>().maxSlider,
        min: context.watch<HomeProvider>().minSlider,
        onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
        Provider.of<HomeProvider>(context, listen: false).changeSlider(_currentSliderValue, 0, 0);
      })
    );
  }
}