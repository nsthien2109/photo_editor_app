import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/modules/navigator.dart';
import 'package:photo_editor_pro/app/providers/editor_provider.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_editor_pro/app/providers/profile_provider.dart';
import 'package:photo_editor_pro/app/providers/template_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        StreamProvider.value(value: FirebaseAuth.instance.authStateChanges(), initialData: null),
        ChangeNotifierProvider(create: (_)=> HomeProvider()),
        ChangeNotifierProvider(create: (_)=> EditorProvider()),
        ChangeNotifierProvider(create: (_)=> TemplateProvider()),
        ChangeNotifierProvider(create: (_)=> ProfileProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'THEIN',
        theme: ThemeData(
          fontFamily: 'Inter',
          primarySwatch: Colors.blue,
        ),
        home: const NavigatorScreen()
      ),
    );

  }
}
