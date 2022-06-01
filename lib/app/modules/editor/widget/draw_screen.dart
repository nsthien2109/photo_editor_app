import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({ Key? key }) : super(key: key);

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  
  static const List<String> listEmoijs = [
    "assets/images/Emojis/Emoji-Psck-1.png",
    "assets/images/Emojis/Emoji-Psck-2.png",
    "assets/images/Emojis/Emoji-Psck-3.png",
    "assets/images/Emojis/Emoji-Psck-4.png",
    "assets/images/Emojis/Emoji-Psck-5.png",
    "assets/images/Emojis/Emoji-Psck-6.png",
    "assets/images/Emojis/Emoji-Psck-7.png",
    "assets/images/Emojis/Emoji-Psck-8.png",
    "assets/images/Emojis/Emoji-Psck-9.png",
    "assets/images/Emojis/Emoji-Psck-10.png",
    "assets/images/Emojis/Emoji-Psck-11.png",
    "assets/images/Emojis/Emoji-Psck-12.png",
    "assets/images/Emojis/Emoji-Psck-13.png",
    "assets/images/Emojis/Emoji-Psck-14.png",
    "assets/images/Emojis/Emoji-Psck-15.png",
    "assets/images/Emojis/Emoji-Psck-16.png",
    "assets/images/Emojis/Emoji-Psck-17.png",
    "assets/images/Emojis/Emoji-Psck-18.png",
    "assets/images/Emojis/Emoji-Psck-19.png",
    "assets/images/Emojis/Emoji-Psck-20.png",
    "assets/images/Emojis/Emoji-Psck-21.png",
    "assets/images/Emojis/Emoji-Psck-22.png",
    "assets/images/Emojis/Emoji-Psck-23.png",
    "assets/images/Emojis/Emoji-Psck-24.png",
    "assets/images/Emojis/Emoji-Psck-25.png",
    "assets/images/Emojis/Emoji-Psck-26.png",
    "assets/images/Emojis/Emoji-Psck-27.png",
    "assets/images/Emojis/Emoji-Psck-28.png"
  ];







  @override
  Widget build(BuildContext context) {
    final heightBottom = widthP(context)/2;
    return Scaffold(
      backgroundColor: secondColor,
      bottomSheet: Container(
        width: widthP(context),
        height: heightBottom,
        color: Colors.black,
      ),
    );
  }
}