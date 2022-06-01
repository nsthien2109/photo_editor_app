import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';

class SearchBarTemplate extends StatefulWidget {
  SearchBarTemplate({Key? key}) : super(key: key);

  @override
  State<SearchBarTemplate> createState() => _SearchBarTemplateState();
}

class _SearchBarTemplateState extends State<SearchBarTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(sizePersen(context, 3)),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: secondColor.withOpacity(.5),
              width: .1
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: secondColor.withOpacity(.5),
              width: .1
            ),
          ),
          suffixIcon: const Icon(Ionicons.search_outline, color: secondColor),
          hintText: "Nhập template cần tìm ... "
        ),
      ),
    );
  }
}