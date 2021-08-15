import 'dart:io';

import 'package:cam_stream/pages/gallery/presntation/controllers/gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:video_player/video_player.dart';

class GalleryView extends GetView<GalleryController> {
  GalleryView({Key? key}) : super(key: key);
  VideoPlayerController? videoController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Gallery',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(20),
          child: Center(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: controller.galleryList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return controller.galleryList[index].type != 'mp4'
                      ? Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                    File(controller.galleryList[index].path)),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15)),
                        )
                      : _thumbnailWidget();
                }),
          ),
        ));
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    final VideoPlayerController? localVideoController = videoController;

    return localVideoController == null
        ? Container(
            decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage('assets/images/play.png'),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(15)),
           
          )
        : Container(
            child: Center(
              child: AspectRatio(
                  aspectRatio: localVideoController.value.size != null
                      ? localVideoController.value.aspectRatio
                      : 1.0,
                  child: VideoPlayer(localVideoController)),
            ),
            decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
          );
  }
}
