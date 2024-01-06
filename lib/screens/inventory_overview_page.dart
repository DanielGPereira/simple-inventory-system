import 'package:flutter/material.dart';
import 'package:simple_inventory_system/data/dabase_connection.dart';
import 'package:simple_inventory_system/data/inventory_item_dao.dart';
import 'package:simple_inventory_system/screens/create_new_inventory_item_page.dart';
import 'package:simple_inventory_system/widgets/centered_circular_progress_indicator.dart';
import 'package:simple_inventory_system/widgets/inventory_item.dart';

import '../models/inventory_item_model.dart';

class InventoryOverviewPage extends StatefulWidget {
  const InventoryOverviewPage({super.key});

  @override
  State<InventoryOverviewPage> createState() => _InventoryOverviewPageState();
}

class _InventoryOverviewPageState extends State<InventoryOverviewPage> {

  void goToCreateNewInventoryItemPage(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => const CreateNewInventoryItemPage()))
        .then((value) {
      setState(() {});
    });
  }

  FloatingActionButton getCreateNewInventoryButton(context) {
    return FloatingActionButton(
      onPressed: () {
        goToCreateNewInventoryItemPage(context);
      },
      child: const Icon(Icons.add, size: 32),
      backgroundColor: Colors.blue,
    );
  }

  ListView getInventoryItemsListView(
      context, List<InventoryItemModel> inventoryItemsModelList) {
    return ListView.builder(
        itemCount: inventoryItemsModelList.length,
        itemBuilder: (context, index) {
          final InventoryItem item =
              InventoryItem.fromModel(inventoryItemsModelList[index], onPop: () {
                setState(() {});
              });
          return item;
        });
  }

  Center getEmptyInventoryIndicatorWidget() {
    return const Center(
        child: Column(
      children: [
        Icon(
          Icons.clear_rounded,
          size: 120,
        ),
        Text(
          'The inventory is empty.\nCreate an item.',
          style: TextStyle(fontSize: 32),
        )
      ],
    ));
  }

  Widget inventoryItemListDatabaseConnectionStatesHandle(context, snapshot) {
    final List<InventoryItemModel>? items = snapshot.data;

    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const CenteredCircularProgressIndicator();

      case ConnectionState.waiting:
        return const CenteredCircularProgressIndicator();

      case ConnectionState.active:
        return const CenteredCircularProgressIndicator();

      case ConnectionState.done:
        if (snapshot.hasData && items != null) {
          if (items.isNotEmpty) {
            return getInventoryItemsListView(context, items);
          }
          return getEmptyInventoryIndicatorWidget();
        }
    }
    return const Text('Unknown error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Overview',
        ),
      ),
      body: FutureBuilder<List<InventoryItemModel>?>(
          future: InventoryItemDao.getAllInventoryItems(),
          builder: (context, snapshot) {
            return inventoryItemListDatabaseConnectionStatesHandle(
                context, snapshot);
          }),
      floatingActionButton: getCreateNewInventoryButton(context),
    );
  }
}
