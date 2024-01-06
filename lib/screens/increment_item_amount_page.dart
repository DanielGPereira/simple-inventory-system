import 'package:flutter/material.dart';
import 'package:simple_inventory_system/data/inventory_item_dao.dart';
import 'package:simple_inventory_system/widgets/centered_circular_progress_indicator.dart';

class IncrementItemAmountPage extends StatelessWidget {
  final String unit;
  final String itemCode;

  const IncrementItemAmountPage(
      {super.key, required this.unit, required this.itemCode});

  @override
  Widget build(BuildContext context) {
    TextEditingController incrementAmountController = TextEditingController();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FutureBuilder(
                  future: InventoryItemDao.incrementAmountInventoryItem(
                      itemCode, double.parse(incrementAmountController.text)),
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
          title: Text(
            itemCode,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'What is the amount you want to add ?',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: TextFormField(
                  controller: incrementAmountController,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      prefix: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(unit, style: const TextStyle(fontSize: 18)),
                  )),
                ),
              )
            ],
          ),
        ));
  }
}
