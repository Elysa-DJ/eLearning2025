import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learning_app/app/data/services/api_service.dart';

import 'app/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync<ApiService>(()=>ApiService().init());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-LEARNING PLATEFORME",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
