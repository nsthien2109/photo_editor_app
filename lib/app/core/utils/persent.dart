import 'package:flutter/cupertino.dart';


double widthP(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double heightP(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double sizeText(BuildContext context,double size){
    size = MediaQuery.of(context).size.width / 100 * (size / 3);
    return size;
}

double sizePersen(BuildContext context,double size){
    size = (MediaQuery.of(context).size.width / 100) * size;
    return size;
}

