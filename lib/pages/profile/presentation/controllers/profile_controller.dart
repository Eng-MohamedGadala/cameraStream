import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../home/presntation/controllers/home_controller.dart';

class ProfileController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  late User user;
  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    if (homeController.googleSign.currentUser != null) {
      await homeController.googleSign.disconnect();
      await homeController.firebaseAuth.signOut();
    } else {
      homeController.signOut();
    }
  }
}
