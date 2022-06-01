import 'package:flutter/cupertino.dart';

class EditorMode{
  String name;
  List<dynamic>? editors;
  IconData? icon;
  Function? onTap;
  EditorMode({required this.name, this.editors , this.icon, this.onTap});
}