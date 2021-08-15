import 'package:cam_stream/components/custom_dialog.dart';
import 'package:cam_stream/pages/home/presntation/controllers/home_controller.dart';
import 'package:cam_stream/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  final _auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> signUp(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.toNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginByEmail(String email, String password) async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if(newUser != null){
        User? user = newUser.user;
        Get.offAllNamed(Routes.CAMERA, arguments: user);
      }
    } catch (e) {
      print(e);
    }
  }

  void login() async {
    CustomFullScreenDialog.showDialog();
    GoogleSignInAccount? googleSignInAccount =
        await homeController.googleSign.signIn();
    if (googleSignInAccount == null) {
      CustomFullScreenDialog.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await homeController.firebaseAuth.signInWithCredential(oAuthCredential);
      CustomFullScreenDialog.cancelDialog();
    }
  }
}
