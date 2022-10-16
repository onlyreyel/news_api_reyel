import 'dart:convert';
import 'dart:developer';

import 'package:blog_news_api/models/loginResponse.dart';
import 'package:blog_news_api/screens/home_screen.dart';
import 'package:blog_news_api/screens/login_screen.dart';
import 'package:blog_news_api/util/constants.dart';
import 'package:blog_news_api/util/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apis/request.dart';

class LoginController extends GetxController {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  SharedPref _sharedPref = SharedPref();

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  void apiLogin() async {
    log("logged");

    Get.dialog(Center(child: const CircularProgressIndicator()),
        barrierDismissible: false);
    Request request = Request(url: urlLogin, body: {
      'email': emailTextController.text,
      'password': passwordTextController.text
    });
    request.post().then((value) async {
      LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(value.body));

      String? token = loginResponse.data?.token;

      await _sharedPref.save("token", token);

      Get.back();
      Get.off(() => HomeScreen());
      print(value.body);
    }).catchError((onError) {});
  }


  logout() async {
    // Delete value
    await _sharedPref.remove("token");

    Get.offAll(() => LoginScreen(), transition: Transition.leftToRight);
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
