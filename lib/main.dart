import 'package:cam_stream/routes/app_pages.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'logger/logger_utils.dart';
import 'pages/home/bindings/home_binding.dart';

List<CameraDescription>?cameras;
Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HomeBinding().dependencies();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialRoute: AppPages.INIRIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}
