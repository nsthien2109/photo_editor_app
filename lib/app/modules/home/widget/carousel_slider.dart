import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SliderImage extends StatelessWidget {
  const SliderImage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(             
        carouselController: context.watch<HomeProvider>().carouselController,
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            Provider.of<HomeProvider>(context, listen: false).changePage(index);
          },
           height: heightP(context) / 1.7
        ),
         items: context.watch<HomeProvider>().photos.map((i) {
           return Builder(
            builder: (BuildContext context) {
              return Stack(
                 children :[ 
                   Container(
                    height: heightP(context) / 2,
                    width: widthP(context),
                     margin: EdgeInsets.symmetric(horizontal: sizePersen(context, 2.0)),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(sizePersen(context, 2.0)),                     
                     ),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(5),
                       child: Image.network(i.src.toString(),fit: BoxFit.cover),
                     )
                    ),
                   Positioned(
                     top: sizePersen(context, 4),
                     right: sizePersen(context, 8),
                     child: Text(i.photographer.toString().toUpperCase(),style: TextStyle(
                      fontSize: sizeText(context, 10),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                       decoration: TextDecoration.underline
                       ),                     
                     )
                   )
                 ]
               );
             },
            );
        }).toList(),
      );
  }
}