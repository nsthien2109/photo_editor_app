import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';

class AppPreferences extends StatefulWidget {
  const AppPreferences({ Key? key }) : super(key: key);

  @override
  State<AppPreferences> createState() => _AppPreferencesState();
}

class _AppPreferencesState extends State<AppPreferences> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: secondColor
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Cài đặt",style: TextStyle(
          color: secondColor
        )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: widthP(context),
              height: widthP(context)/5.5,
              padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 3)),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: lightGrey.withOpacity(.2)
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chế độ ban đêm", style: TextStyle(
                    color: secondColor,
                    fontSize: sizeText(context, 14)
                  )),
                  Switch(
                    value: true,
                    onChanged: (value) {

                    },
                    activeTrackColor: lightGrey,
                    activeColor: secondColor,
                  ),
                ],
              ),
            ),
            Container(
              width: widthP(context),
              height: widthP(context)/5.5,
              padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 3)),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: lightGrey.withOpacity(.2)
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Điều khoản sử dụng", style: TextStyle(
                    color: secondColor,
                    fontSize: sizeText(context, 14)
                  )),
                  const Icon(Ionicons.arrow_forward_outline)
                ],
              ),
            ),
            Container(
              width: widthP(context),
              height: widthP(context)/5.5,
              padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 3)),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: lightGrey.withOpacity(.2)
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Giấy phép mở nguồn", style: TextStyle(
                    color: secondColor,
                    fontSize: sizeText(context, 14)
                  )),
                  const Icon(Ionicons.arrow_forward_outline)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}