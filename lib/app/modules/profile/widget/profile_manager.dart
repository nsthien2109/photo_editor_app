import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/providers/profile_provider.dart';
import 'package:photo_editor_pro/app/widgets/small_button.dart';
import 'package:provider/provider.dart';

class ProfileManager extends StatelessWidget {
  const ProfileManager({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: secondColor
        ),
        title: const Text("Quản lý tài khoản",style: TextStyle(color: secondColor)),
        centerTitle: true,
      ),
      body: SizedBox(
        width: widthP(context),
        child: Padding(
          padding: EdgeInsets.only(bottom: sizePersen(context, 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmallButton(label: "Đăng xuất", onTap: (){
                Provider.of<ProfileProvider>(context, listen: false).signOut();
                Navigator.pop(context);
              }),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)
                ),
                onPressed: (){}, 
                child: Text("Xóa tài khoản",style: TextStyle(
                    fontSize: sizeText(context, 12),
                    color: lightGrey,
                    decoration: TextDecoration.underline
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}