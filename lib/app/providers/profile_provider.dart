import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_editor_pro/app/core/utils/authentification.dart';
import 'package:photo_editor_pro/app/core/utils/share_prefers.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier{
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  String _name = 'Unknow';
  String get name => _name;

  String _uid = '';
  String get uid => _uid;

  Future<void> login() async {
    try {
      User? user = await Authentification().signInWithGoogle();
      await setKeyBool("isLogin", true);
      await setKeyString("userName", user?.displayName);
      await setKeyString("userId", user?.uid);
      getInfo();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getInfo()async{
    _name = await getKeyString("userName") ?? "Unknow";
    _uid = await getKeyString("userId") ?? "";
    _isLogin = await getKeyBool("isLogin") ?? false;
    notifyListeners();
  }

  Future<void> signOut()async {
    try {
      await Authentification().signOut();
      await removeKey("isLogin");
      await removeKey("userName");
      await removeKey("userId");
      getInfo();
      print("EXCUTE SIGN OUT");
    } catch (e) {
      rethrow;
    }
  }
}