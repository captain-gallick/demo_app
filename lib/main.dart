import 'package:demo_app/constants.dart';
import 'package:demo_app/contacts_adapter.dart';
import 'package:demo_app/list_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'details_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactsAdapterAdapter());
  Hive.openBox<ContactsAdapter>(Constants.hiveBox);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const ListPage(),
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}
