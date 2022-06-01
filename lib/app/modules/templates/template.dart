import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_editor_pro/app/core/utils/persent.dart';
import 'package:photo_editor_pro/app/core/utils/share_prefers.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/data/models/template.dart';
import 'package:photo_editor_pro/app/modules/templates/widgets/search_bar.dart';
import 'package:photo_editor_pro/app/modules/templates/widgets/template_item.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_editor_pro/app/providers/profile_provider.dart';
import 'package:photo_editor_pro/app/providers/template_provider.dart';
import 'package:photo_editor_pro/app/widgets/loading.dart';
import 'package:provider/provider.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({ Key? key }) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  bool isLogin = false;
  String userName = "Unknow";

  Future<void> getStates() async {
    final login = await getKeyBool("isLogin") ?? false;
    setState(() {
      isLogin = login;
    });
  }

  @override
  void initState() {
    getStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SearchBarTemplate(),
          StreamBuilder<List<TemplateModel>>(
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
                  children: templates.where((element) => element.isApproved == true).map((e) => TemplateItem(template: e)).toList(),
                );
              }else if(snapshot.hasError){
                return Text("Somthing went wrong : " + snapshot.error.toString());
              }else{
                return const Loading();
              }
            }
          )
        ],
      ),
      floatingActionButton: isLogin ?  FloatingActionButton(
        mini: true,
        tooltip: "Tạo template của bạn",
        elevation: 5,
        backgroundColor: secondColor,
        onPressed: ()=> Provider.of<HomeProvider>(context, listen:  false).getImageCreateTemplate(context),
        child: const Icon(Ionicons.add_outline),
      ) : null,
    );
  }
}