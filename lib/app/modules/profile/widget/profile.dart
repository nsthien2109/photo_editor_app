import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/utils/share_prefers.dart';
import 'package:photo_editor_pro/app/providers/profile_provider.dart';
import 'package:photo_editor_pro/app/widgets/count_content.dart';
import 'package:provider/provider.dart';

class InfoProfile extends StatelessWidget {
  const InfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = heightP(context) - sizePersen(context, 15);
    return SizedBox(
      height: height / 7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 4)),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  radius: sizePersen(context, 9),
                  child: Text("T",style: TextStyle(
                      fontSize: sizeText(context, 25),
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )),
                ),
                SizedBox(width: sizePersen(context, 3)),
                Text(context.watch<ProfileProvider>().name,style: TextStyle(
                    fontSize: sizeText(context, 15),
                    fontWeight: FontWeight.w600
                ))
              ],
            ),
            SizedBox(height: sizePersen(context, 5)),
            Row(
              children: [
                context.watch<ProfileProvider>().isLogin ? CountContent(counter: 0,label: "Đang theo dõi") : Container(),
                SizedBox(width: sizePersen(context, 4)),
                context.watch<ProfileProvider>().isLogin ? CountContent(counter: 0,label: "Người theo dõi") : Container(),
                SizedBox(width: sizePersen(context, 4)),
                context.watch<ProfileProvider>().isLogin ? CountContent(counter: 0,label: "Lượt dùng") : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
