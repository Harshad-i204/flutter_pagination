import 'package:flutter/material.dart';
import 'package:flutter_pagination/src/controller/scroll_page_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollPageController scrollPageController = Get.put(ScrollPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScrollPageController>(
      builder: (pageController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Flutter Pagination Example",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          body: pageController.isFirstRunningLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: pageController.posts.length,
                        shrinkWrap: true,
                        controller: pageController.controller,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: ListTile(
                              title: Text(pageController.posts[index]['title']),
                              subtitle:
                                  Text(pageController.posts[index]['body']),
                            ),
                          );
                        },
                      ),
                    ),
                    if (pageController.isLoadMorerunning == true)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                  ],
                ),
        );
      },
    );
  }
}
