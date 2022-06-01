import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/modules/home/widget/carousel_slider.dart';
import 'package:photo_editor_pro/app/modules/home/widget/choose_image.dart';
import 'package:photo_editor_pro/app/modules/home/widget/home_prefs.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_editor_pro/app/widgets/big_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: secondColor
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: sizePersen(context, 1.5)),
            child: IconButton(
              splashRadius: sizePersen(context, 2),
              onPressed: ()=>Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.topRight,duration: const Duration(seconds: 1) , child: const AppPreferences())),
              icon: const Icon(Ionicons.settings_outline)
            ),
          )
        ],
      ),
      body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: sizePersen(context, 4)),
              child: const SliderImage()
            ),
            Padding(
                padding: EdgeInsets.only(top: sizePersen(context, 1)),
                child: DotsIndicator(
                  mainAxisAlignment: MainAxisAlignment.center,
                  dotsCount: 10,
                  position:  context.watch<HomeProvider>().pageIndex.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: secondColor,
                    color: const Color(0xFFF5F5F5),
                    size:  const Size(5.0,3.0),
                    activeSize: const Size(15.0, 3.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(sizePersen(context, 8)),
              child: Center(
                child: BigButton(label: 'Bắt đầu sửa', onTap: ()=> showModalBottomSheet(
                  context: context, 
                  builder: (BuildContext context) => const ChooseImageSource()
                ))
              ),
            ) 
          ],
        ),
    );
  }
}