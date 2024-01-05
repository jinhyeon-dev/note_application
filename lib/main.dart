import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:note_application/add_page/add_page.dart';
import 'package:note_application/main_page/main_page.dart';
import 'package:note_application/note_page/note_page.dart';
import 'package:note_application/service/database_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseClient.instance.initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const MainPage(),
        ),
        GetPage(
          name: '/add',
          page: () => AddPage(),
        ),
        GetPage(
          name: '/note',
          page: () => const NotePage(),
        ),
      ],
      initialRoute: '/',
    );
  }
}