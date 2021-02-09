import 'package:flutter/material.dart';
import 'package:reviewapp/features/review/presentation/pages/review_page.dart';
import 'package:reviewapp/injection_container.dart';

void main() async {
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReviewPage(),
    );
  }
}
