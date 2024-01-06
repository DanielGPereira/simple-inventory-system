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
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FutureBuilder(
                  future: InventoryItemDao.incrementAmountInventoryItem(
                      itemCode, double.parse(incrementAmountController.text)),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return CenteredCircularProgressIndicator();
                      case ConnectionState.waiting:
                        return CenteredCircularProgressIndicator();
                      case ConnectionState.active:
                        return CenteredCircularProgressIndicator();
                      case ConnectionState.done:
                        Navigator.pop(context);
                    }
                    return Text('Unknoun Error');
                  });
            })).then((value) {
              Navigator.pop(context);
            });
          },
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(itemCode, style: TextStyle(color: Colors.white),),
          backgroundColor: const Color.fromRGBO(13, 13, 13, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'What is the amount you want to add ?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: TextFormField(
                  controller: incrementAmountController,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      prefix: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(unit,
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  )),
                ),
              )
            ],
          ),
        ));
  }
}
