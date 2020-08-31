import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WatchPage extends StatelessWidget {

  final url;

  WatchPage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: WebviewScaffold(
            url: url,
          ),
        ),
      ),
    );
  }
}
