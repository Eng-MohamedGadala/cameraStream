import 'package:cam_stream/pages/auth/bindings/auth_binding.dart';
import 'package:cam_stream/pages/auth/presntation/views/login_view.dart';
import 'package:cam_stream/pages/auth/presntation/views/signup_view.dart';
import 'package:cam_stream/pages/gallery/bindings/gallery_binding.dart';
import 'package:cam_stream/pages/gallery/presntation/views/gallery_view.dart';
import 'package:cam_stream/pages/home/bindings/home_binding.dart';
import 'package:cam_stream/pages/profile/bindings/profile_binding.dart';
import 'package:cam_stream/pages/home/presntation/views/camera_view.dart';
import 'package:cam_stream/pages/home/presntation/views/home_view.dart';
import 'package:cam_stream/pages/profile/presentation/views/profile_view.dart';
import 'package:get/route_manager.dart';
part 'app_routes.dart';

class AppPages {
  static const INIRIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CAMERA,
      page: () => CameraView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: Routes.GALLERY,
        page: () => GalleryView(),
        binding: GalleryBinding()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
