import 'package:blog_news_api/core/controllers/home_controller.dart';
import 'package:blog_news_api/core/controllers/login_controllers.dart';
import 'package:blog_news_api/screens/details_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home_screen";

  final LoginController _loginController = Get.find();
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'News',
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _homeController.userListData.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen()));
                    },
                    child: ListTile(
                      title: Text(
                        _homeController.userListData[index].title ?? "",
                      ),
                      subtitle: Text(
                        _homeController.userListData[index].subTitle ?? "",
                      ),
                      leading: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _homeController.deleteItem(index);
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
