import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ScrollPageController extends GetxController {
  final _baseurl = 'https://jsonplaceholder.typicode.com/posts';

  int _page = 0;

  final int _limit = 10;
  bool hasNextPage = true;

  bool isLoadMorerunning = false;

  bool isFirstRunningLoading = false;

  List posts = [];

  late ScrollController controller;

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstRunningLoading == false &&
        isLoadMorerunning == false &&
        controller.position.extentAfter < 300) {
      isLoadMorerunning = true;
      update();
      _page += 1;
      try {
        final response =
            await http.get(Uri.parse("$_baseurl?_page=$_page?_limit=$_limit"));
        final List fetchPosts = jsonDecode(response.body);
        if (fetchPosts.isNotEmpty) {
          posts.addAll(fetchPosts);
          update();
        } else {
          hasNextPage = false;
          update();
        }
      } catch (err) {
        if (kDebugMode) {
          print("Error : $err");
        }
      }

      isLoadMorerunning = false;
      update();
    }
  }

  void _firstLoad() async {
    isFirstRunningLoading = true;
    update();
    try {
      final response =
          await http.get(Uri.parse('$_baseurl?_page=$_page?_limit=$_limit'));
      posts = jsonDecode(response.body);
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
    }

    isFirstRunningLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _firstLoad();
    controller = ScrollController()..addListener(loadMore);
  }
}
