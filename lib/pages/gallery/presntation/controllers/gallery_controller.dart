import 'package:cam_stream/pages/gallery/domain/entity/gallery_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GalleryController extends GetxController {
  List<GalleryModel> galleryList = [];
  @override
  void onInit() {
    super.onInit();
  }

  addItemToGalleryList(GalleryModel galleryItem) {
    galleryList.add(galleryItem);
    update();
  }
}
