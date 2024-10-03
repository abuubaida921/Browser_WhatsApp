import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var tabs = <String>[].obs; // Observable list of tab titles
  var currentIndex = 0.obs;  // Observable for the currently selected tab

  void addTab(String tabTitle) {
    tabs.add(tabTitle); // Add new tab dynamically
  }

  void removeTab(int index) {
    if (tabs.length > index) {
      tabs.removeAt(index); // Remove tab by index
    }
  }

  void changeTabIndex(int index) {
    currentIndex.value = index; // Change the selected tab
  }


  double progress = 0;
  var currentURL = 'https://abuubaida921.com/';
  bool isFirstTime = true;
  late InAppWebViewController inAppWebViewController;
  var isPreviousPage = false;
  var isNextPage = false;
  PullToRefreshController? pullToRefreshController;
  PullToRefreshOptions pullToRefreshSettings = PullToRefreshOptions(
    color: Colors.blue,
  );
}
