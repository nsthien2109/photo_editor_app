import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/data/models/template.dart';
import 'package:photo_editor_pro/app/modules/profile/widget/profile.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_editor_pro/app/modules/profile/widget/profile_manager.dart';
import 'package:photo_editor_pro/app/modules/templates/widgets/template_item.dart';
import 'package:photo_editor_pro/app/providers/profile_provider.dart';
import 'package:photo_editor_pro/app/providers/template_provider.dart';
import 'package:photo_editor_pro/app/widgets/loading.dart';
import 'package:photo_editor_pro/app/widgets/small_button.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = heightP(context) - sizePersen(context, 37);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: secondColor
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ProfileManager())), icon: const Icon(Ionicons.remove_sharp))
        ],
      ),
      body: SizedBox(
        height: height,
        width: widthP(context),
        child: Column(
          children: [
            const InfoProfile(),
            SizedBox(height: sizePersen(context, 8)),
            SizedBox(
              height:  height - (height/4.7),
              width: widthP(context),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: sizePersen(context, 3)),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: lightGrey.withOpacity(.2)
                            )
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 4)),
                      child: Text("Template của bạn",style: TextStyle(
                          fontSize: sizeText(context, 13)
                      )),
                    ),
                  ),
                  context.watch<ProfileProvider>().isLogin == false ? Center(
                    child: Column(
                      children: [
                        Lottie.asset('assets/jsons/empty_folder.json',width: sizePersen(context, 80)),
                        Text("Hãy thêm những template của bạn nào !",style: TextStyle(
                            fontSize: sizeText(context, 12),
                            color: lightGrey
                        ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: sizePersen(context, 10)),
                        SmallButton(label: "Đăng nhập", onTap: ()=> showLogin(context))
                      ],
                    ),
                  ) : StreamBuilder<List<TemplateModel>>(
                      stream: Provider.of<TemplateProvider>(context, listen: false).getTemplates(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          final templates = snapshot.data!;
                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: sizePersen(context, 3)),
                            physics: const ClampingScrollPhysics(),
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            children: templates.where((element) => element.userId == context.watch<ProfileProvider>().uid).map((e) => TemplateItem(template: e)).toList(),
                          );
                        }else if(snapshot.hasError){
                          return Text("Somthing went wrong : " + snapshot.error.toString());
                        }else{
                          return const Loading();
                        }
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showLogin(context){
    showModalBottomSheet(
        context: context,
        builder: (_)=> Container(
          padding: EdgeInsets.all(sizePersen(context, 10)),
          height: widthP(context) / 3,
          child: GestureDetector(
            onTap:()=> Provider.of<ProfileProvider>(context, listen:  false).login(),
            child: Container(
              width: widthP(context) / 2,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Colors.amber[200]!
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Emojis/google_ic.png', width: sizePersen(context, 10)),
                  SizedBox(width: sizePersen(context, 3)),
                  const Text("Đăng nhập với tài khoản Google")
                ],
              ),
            ),
          ),
        )
    );
  }
}
