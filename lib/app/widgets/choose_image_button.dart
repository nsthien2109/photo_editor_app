import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';

class ChooseImageButton extends StatelessWidget {
  String title;
  Color color;
  IconData icon;
  Function onTap;
  ChooseImageButton({Key? key, required this.title,required this.icon,required this.color,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
         onTap: ()=> onTap(),
        child: Container(
          width: widthP(context) / 6.5,
          height: widthP(context)/ 6.5,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
             boxShadow: const [
               BoxShadow(
                 color: Color.fromRGBO(99, 99, 99, 0.2),
                offset: Offset(0,2),
                blurRadius: 8,
                 spreadRadius: 0
               )
             ]
           ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(icon,size: sizeText(context, 20)),
               SizedBox(height: sizePersen(context, 1.5)),
              Text(title,style: TextStyle(
                 fontSize: sizeText(context, 10)
               ))
             ],
          ),
        ),
      );
  }
}