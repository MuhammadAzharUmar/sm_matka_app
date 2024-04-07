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
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
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

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: kWhiteColor,
            )),
        backgroundColor: kBlue1Color,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: kMediumTextStyle.copyWith(
              color: kWhiteColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (isLoading)
            Center(
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: kDarkGredientColor,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
