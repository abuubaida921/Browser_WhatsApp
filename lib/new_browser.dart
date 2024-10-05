import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller.dart';

class InAppWebViewNew extends GetView<newBrowserController> {
  const InAppWebViewNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(title: Text("WhatsApp Desktop App")),
          body: SafeArea(
              child: Column(children: <Widget>[
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: controller.listOfGlobalKey.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectedIndex.value = index;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: index == controller.selectedIndex.value
                                  ? Colors.green
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text('Tab ${index + 1}'),
                                controller.inAppWebViewList.length > 1
                                    ? IconButton(
                                        icon: Icon(Icons.close, size: 16),
                                        onPressed: () {
                                          controller.removeTab(index);
                                        },
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  controller.inAppWebViewList[controller.selectedIndex.value]
                ],
              ),
            ),
          ])),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.listOfGlobalKey.add(GlobalKey<FormState>());
              controller.settingsList.add(InAppWebViewSettings(
                isInspectable: kDebugMode,
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                iframeAllow: "camera; microphone",
                iframeAllowFullscreen: true,
              ));

              controller.inAppWebViewList.add(InAppWebView(
                key: controller.listOfGlobalKey[controller.selectedIndex.value],
                initialUrlRequest:
                    URLRequest(url: WebUri('https://web.whatsapp.com/')),
                // initialUrlRequest:
                // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
                // initialFile: "assets/index.html",
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                initialSettings:
                    controller.settingsList[controller.selectedIndex.value],
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
              ));
              controller.selectedIndex.value += 1;
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
