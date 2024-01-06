import 'package:flutter/material.dart';
import 'package:simple_inventory_system/data/inventory_item_dao.dart';
import 'package:simple_inventory_system/widgets/centered_circular_progress_indicator.dart';

class DecrementItemAmountPage extends StatelessWidget {
  final String unit;
  final String itemCode;

  const DecrementItemAmountPage(
      {super.key, required this.unit, required this.itemCode});

  @override
  Widget build(BuildContext context) {
    TextEditingController decrementAmountController = TextEditingController();

    return Scaffold(
        floatingActionButton: FloatingActionButton( child: const Icon(Icons.remove),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FutureBuilder(
                  future: InventoryItemDao.decrementAmountInventoryItem(
                      itemCode, double.parse(decrementAmountController.text)),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const CenteredCircularProgressIndicator();
                      case ConnectionState.waiting:
                        return const CenteredCircularProgressIndicator();
                      case ConnectionState.active:
                        return const CenteredCircularProgressIndicator();
                      case ConnectionState.done:
                        Navigator.pop(context);
                    }
                    return const Text('Unknoun Error');
                  });
            })).then((value) {
              Navigator.pop(context);
            });
          },
        ),
        appBar: AppBar(
          title: Text(itemCode),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'What is the amount you want to remove ?',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: TextFormField(
                  controller: decrementAmountController,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(unit,
                            style: const TextStyle(color: Colors.white, fontSize: 18)),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}