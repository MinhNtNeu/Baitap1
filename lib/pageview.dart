import 'package:besoul/onbroad2.dart';
import 'package:besoul/onbroad3.dart';
import 'package:besoul/onbroad_page.dart';
import 'package:flutter/material.dart';
class PageViewExampleApp extends StatefulWidget {
  const PageViewExampleApp({super.key});
  @override
  State<PageViewExampleApp> createState() => _PageViewExampleAppState();
}

class _PageViewExampleAppState extends State<PageViewExampleApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: PageViewExample(),
      ),
    );
  }
}

class PageViewExample extends StatelessWidget {
  const PageViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children:  const <Widget>[
        Center(
          child: OnboardPage(),
        ),
        Center(
          child: OnboardPage2(),
        ),
        Center(
          child: OnboardPage3(),
        ),
      ],
    );
  }
}
