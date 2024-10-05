import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class newBrowserController extends GetxController {
  final listOfGlobalKey = <GlobalKey<FormState>>[].obs;
  final settingsList = <InAppWebViewSettings>[].obs;
  final inAppWebViewList = <InAppWebView>[].obs;

  InAppWebViewController? webViewController;

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    listOfGlobalKey.add(GlobalKey<FormState>());
    settingsList.add(InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true,
    ));
    inAppWebViewList.add(
      InAppWebView(
        key: listOfGlobalKey[selectedIndex.value],
        initialUrlRequest: URLRequest(url: WebUri('https://web.whatsapp.com/')),
        // initialUrlRequest:
        // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
        // initialFile: "assets/index.html",
        initialUserScripts: UnmodifiableListView<UserScript>([]),
        initialSettings: settingsList[selectedIndex.value],
        onWebViewCreated: (controller) async {
          // controller.webViewController = controller;
        },
        onLoadStart: (controller, url) async {},
        onPermissionRequest: (controller, request) async {
          return PermissionResponse(
              resources: request.resources,
              action: PermissionResponseAction.GRANT);
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;

          if (![
            "http",
            "https",
            "file",
            "chrome",
            "data",
            "javascript",
            "about"
          ].contains(uri.scheme)) {
            if (await canLaunchUrl(uri)) {
              // Launch the App
              await launchUrl(
                uri,
              );
              // and cancel the request
              return NavigationActionPolicy.CANCEL;
            }
          }

          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {},
        onReceivedError: (controller, request, error) {},
        onProgressChanged: (controller, progress) {},
        onUpdateVisitedHistory: (controller, url, isReload) {},
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    );
  }

  void removeTab(index) {
    inAppWebViewList.removeAt(index);
    settingsList.removeAt(index);
    listOfGlobalKey.removeAt(index);
    if (listOfGlobalKey.isNotEmpty) selectedIndex.value = 0;
  }

}
