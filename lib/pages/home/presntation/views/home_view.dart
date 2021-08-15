import 'package:cam_stream/pages/home/presntation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.yellowAccent),
        ),
      ),
    );
  }
}
