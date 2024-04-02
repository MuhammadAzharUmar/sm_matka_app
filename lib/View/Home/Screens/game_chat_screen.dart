import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GameChartScreen extends StatefulWidget {
  const GameChartScreen(
      {super.key, required this.title, required this.chatUrl});
  final String title;
  final String chatUrl;
  @override
  State<GameChartScreen> createState() => _GameChartScreenState();
}

class _GameChartScreenState extends State<GameChartScreen> {
    late WebViewController controller;
    @override
  void initState() {
    super.initState();
    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith(widget.chatUrl)) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(widget.chatUrl));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblue1color,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: kblue1color,
            )),
        backgroundColor: kBlue1Color,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: kMediumTextStyle.copyWith(
              color: kblue1color, fontWeight: FontWeight.w700),
        ),
      ),
      body: WebViewWidget(
        controller: controller, 
            ),
    );
  }
}
