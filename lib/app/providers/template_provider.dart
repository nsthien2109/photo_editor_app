import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_editor_pro/app/data/models/template.dart';

class TemplateProvider extends ChangeNotifier{
  
  Future createTemplate(
    String name_template,
    num brightness,
    num contrast,
    num saturation,
    num red,
    num green, 
    num blue,
    String author,
    String userId
  ) async {
    final docsTemplate = FirebaseFirestore.instance.collection('template_editors').doc();
    final template = TemplateModel(
      id: docsTemplate.id,
      nameTemplate: name_template,
      brightness: brightness.toDouble(),
      contrast: contrast.toDouble(),
      saturation: saturation.toDouble(),
      red: red.toInt(),
      green: green.toInt(),
      blue: blue.toInt(),
      author: author,
      userId: userId,
      isApproved: false
    );

    final jsonTemplate = template.toJson();

    await docsTemplate.set(jsonTemplate);
  }

 
  Stream<List<TemplateModel>> getTemplates() => FirebaseFirestore.instance.collection('template_editors')
    .snapshots().
    map((snapshot) => snapshot.docs.map((e) => TemplateModel.fromJson(e.data())).toList());
}
