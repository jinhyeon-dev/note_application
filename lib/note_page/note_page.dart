import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    Map data = Get.arguments as Map;
    return Scaffold(
      appBar: AppBar( 
        title: Text(data['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Text(data['content']),
        ),
      ),
    );
  }
}
