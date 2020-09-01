import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:movie_app/models/movie_model.dart';

class WatchPage extends StatelessWidget {
  final String url;
  WatchPage({Key key, @required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebviewScaffold(
          url: url,
        )
    );
  }
}
