import 'package:flutter/material.dart';
import 'package:simple_inventory_system/screens/create_new_inventory_item_page.dart';
import 'package:simple_inventory_system/screens/increment_item_amount_page.dart';
import 'package:simple_inventory_system/screens/inventory_item_page.dart';
import 'package:simple_inventory_system/screens/inventory_overview_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(13, 13, 13, 1)),
        useMaterial3: true,
      ),
      home: InventoryOverviewPage()
    );
  }
}
