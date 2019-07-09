// Flutter code sample for material.AppBar.1

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/material.dart';
import 'VC/discover.dart';


void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MainPage(),
      // debugShowMaterialGrid:true,
      // showPerformanceOverlay: true,
      // showSemanticsDebugger:true
      // routes: {
      //   "/home": (context) => MainPage(),
      //   "/home/moment": (context) => MomentPage(),
      //   "/home/moment/imagePageView": (context) => ImagePageView(),
      // },
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
