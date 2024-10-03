import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        // bottom: Obx(() {
        //   return TabBar(
        //     isScrollable: true, // To accommodate dynamic number of tabs
        //     onTap: tabController.changeTabIndex,
        //     tabs: tabController.tabs.map((tabTitle) {
        //       return Tab(text: tabTitle);
        //     }).toList(),
        //   );
        // }),
      ),
      body: Obx(() {
        return Column(
          children: [
            controller.tabs.isEmpty?const SizedBox.shrink():SizedBox(
              height: 40, // Increased height for better tab appearance
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.tabs.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: (){controller.changeTabIndex(index);},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Tab background color
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26, // Shadow color for depth
                              blurRadius: 4, // Blur radius for the shadow
                              offset: Offset(2, 2), // Offset for the shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Tab ${index + 1}',
                              style: const TextStyle(
                                fontSize: 16, // Adjust font size
                                fontWeight: FontWeight.bold, // Make the tab title bold
                                color: Colors.black, // Text color
                              ),
                            ),
                            const SizedBox(width: 10), // Space between text and close icon
                            InkWell(
                              onTap: () {
                                controller.removeTab(index); // Tab removal action
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black54, // Close icon color
                                size: 18, // Icon size
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            Column(children: <Widget>[
              TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                controller: controller.urlController,
                keyboardType: TextInputType.text,
                onSubmitted: (value) {
                  var url = WebUri(value);
                  if (url.scheme.isEmpty) {
                    url = WebUri((!kIsWeb
                        ? "https://www.google.com/search?q="
                        : "https://www.bing.com/search?q=") +
                        value);
                  }
                  controller.webViewController?.loadUrl(urlRequest: URLRequest(url: url));
                },
              ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: controller.webViewKey,
                      webViewEnvironment: webViewEnvironment,
                      initialUrlRequest:
                      URLRequest(url: WebUri('https://web.whatsapp.com/')),
                      // initialUrlRequest:
                      // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
                      // initialFile: "assets/index.html",
                      initialUserScripts: UnmodifiableListView<UserScript>([]),
                      initialSettings: controller.settings,
                      contextMenu: controller.contextMenu,
                      pullToRefreshController: controller.pullToRefreshController,
                      onWebViewCreated: (ctrl) async {
                        controller.webViewController = ctrl;
                      },
                      onLoadStart: (controller, url) async {
                        // setState(() {
                        //   this.url = url.toString();
                        //   urlController.text = this.url;
                        // });
                      },
                      onPermissionRequest: (controller, request) async {
                        return PermissionResponse(
                            resources: request.resources,
                            action: PermissionResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
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
                      onLoadStop: (ctrl, url) async {
                        controller.pullToRefreshController?.endRefreshing();
                        // setState(() {
                        //   this.url = url.toString();
                        //   urlController.text = this.url;
                        // });
                      },
                      onReceivedError: (ctrl, request, error) {
                        controller.pullToRefreshController?.endRefreshing();
                      },
                      onProgressChanged: (ctrl, progress) {
                        if (progress == 100) {
                          controller.pullToRefreshController?.endRefreshing();
                        }
                        // setState(() {
                        //   this.progress = progress / 100;
                        //   urlController.text = this.url;
                        // });
                      },
                      onUpdateVisitedHistory: (ctrl, url, isReload) {
                        // setState(() {
                        //   this.url = url.toString();
                        //   urlController.text = this.url;
                        // });
                      },
                      onConsoleMessage: (ctrl, consoleMessage) {
                        print(consoleMessage);
                      },
                    ),
                    controller.progress < 1.0
                        ? LinearProgressIndicator(value: controller.progress)
                        : Container(),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Icon(Icons.arrow_back),
                    onPressed: () {
                      controller.webViewController?.goBack();
                    },
                  ),
                  ElevatedButton(
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      controller.webViewController?.goForward();
                    },
                  ),
                  ElevatedButton(
                    child: Icon(Icons.refresh),
                    onPressed: () {
                      controller.webViewController?.reload();
                    },
                  ),
                ],
              ),
            ]),
            // Expanded(
            //   child: Container(
            //     width: Get.size.width,
            //     color: Colors.red,
            //     child:
            //     Text(
            //       'Tab ${controller.currentIndex.value + 1} body',
            //       style: TextStyle(
            //         fontSize: 16, // Adjust font size
            //         fontWeight: FontWeight.bold, // Make the tab title bold
            //         color: Colors.white, // Text color
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new tab dynamically
          controller.addTab("Tab ${controller.tabs.length + 1}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}