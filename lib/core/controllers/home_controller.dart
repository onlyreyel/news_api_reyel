import 'dart:convert';
import 'package:blog_news_api/apis/request.dart';
import 'package:blog_news_api/models/userList.dart';
import 'package:blog_news_api/util/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../util/sharedPref.dart';

class HomeController extends GetxController {
  var userListData = <Data>[].obs;

  SharedPref _sharedPref = SharedPref();


  @override
  void onInit() {
    _apiGetUserList();
    super.onInit();
  }

  void _apiGetUserList() async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));

    String? token = await _sharedPref.read("token");

    var headers = {

      'content-type': "application/json",
      'Authorization': 'Bearer $token'

    };

    Request request = Request(url: urlUserList, body: null,headers: headers);
    request.get().then((value) {
      BlogList userListModel = BlogList.fromJson(json.decode(value.body));
      userListData.value = userListModel.data!.blogs!.data!;
      Get.back();
    }).catchError((onError) {
      print(onError);
    });
  }

  void deleteItem(int index) {
    userListData.removeAt(index);
  }
}