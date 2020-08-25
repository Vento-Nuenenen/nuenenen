import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuenenen/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: mainColor,
        actionsForegroundColor: Colors.white,
        previousPageTitle: "Zurück",
        middle: new Text(
          "Hilfe",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: const WebView(
        initialUrl: 'https://github.com/Vento-Nuenenen/nuenenen/wiki/Help',
        javaScriptMode: JavaScriptMode.unrestricted,
      ),
    );
  }
}