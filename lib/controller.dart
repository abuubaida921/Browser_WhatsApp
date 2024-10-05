import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class newBrowserController extends GetxController {
  final browserInstances = <BrowserInstance>[].obs;
  final selectedIndex = 0.obs;

  void addBrowser() {
    browserInstances.add(BrowserInstance());
  }

  void removeBrowser(int index) {
    if (browserInstances.length > index) {
      browserInstances.removeAt(index);
      if (selectedIndex.value >= browserInstances.length) {
        selectedIndex.value = browserInstances.length - 1;
      }
    }
  }
}

class BrowserInstance {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  final CookieManager cookieManager = CookieManager();

  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: true,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  // Method to clear cookies for this instance
  Future<void> clearCookies() async {
    await cookieManager.deleteAllCookies();
  }
}
