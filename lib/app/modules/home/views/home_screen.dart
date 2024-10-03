import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';

import '../controllers/home_screen_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length, // Define the number of tabs
      child: Scaffold(
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
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(controller.currentURL)),
                onReceivedServerTrustAuthRequest:
                    (controller, challenge) async {
                  return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED,
                  );
                },
                pullToRefreshController: controller.pullToRefreshController,
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                    allowFileAccessFromFileURLs: true,
                    useOnDownloadStart: true,
                    javaScriptCanOpenWindowsAutomatically: true,
                    javaScriptEnabled: true,
                    supportZoom: true,
                  ),
                  android:
                  AndroidInAppWebViewOptions(useHybridComposition: true),
                  ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
                ),
                onWebViewCreated: (InAppWebViewController ctrl) {
                  controller.inAppWebViewController = ctrl;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) async {
                  Uri? url = await controller.getUrl();
                  debugPrint("Current URL: ${url?.toString()}");
                  // setState(() {
                  //   currentURL = "${url?.toString()}";
                  //   _progress = progress / 100;
                  //   isFirstTime = false;
                  // });
                  // if (_progress == 1) {
                  //   isPreviousPage = await inAppWebViewController.canGoBack();
                  //   isNextPage = await inAppWebViewController.canGoForward();
                  // } else if (_progress > .5) {
                  //   pullToRefreshController?.endRefreshing();
                  // }
                },
              ),
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
      ),
    );
  }
}