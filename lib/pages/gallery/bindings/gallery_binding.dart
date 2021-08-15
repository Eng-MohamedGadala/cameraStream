import 'package:cam_stream/pages/gallery/presntation/controllers/gallery_controller.dart';
import 'package:get/get.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GalleryController>(GalleryController());
  }
}
