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
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text("WhatsApp Desktop App")),
        body: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                itemCount: controller.browserInstances.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, size: 16),
                          onPressed: () {
                            controller.removeBrowser(index);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectedIndex.value = index;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: index == controller.selectedIndex.value ? Colors.green : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Browser ${index + 1}'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.browserInstances.isEmpty) {
                  return Center(child: Text('No browsers added.'));
                }
                return InAppWebView(
                  key: controller.browserInstances[controller.selectedIndex.value].webViewKey,
                  initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://web.whatsapp.com/'),),),
                  initialSettings: controller.browserInstances[controller.selectedIndex.value].settings,
                  onWebViewCreated: (controller) {
                    // controller.browserInstances[controller.selectedIndex.value].webViewController = controller;
                  },
                  onLoadStart: (controller, url) async {},
                  onPermissionRequest: (controller, request) async {
                    return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT,
                    );
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
                    if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
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
                );
              }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.addBrowser,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
