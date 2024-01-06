import 'package:flutter/material.dart';
import 'package:simple_inventory_system/data/inventory_item_dao.dart';
import 'package:simple_inventory_system/models/inventory_item_model.dart';
import 'package:simple_inventory_system/screens/increment_item_amount_page.dart';
import 'package:simple_inventory_system/widgets/centered_circular_progress_indicator.dart';
import 'package:simple_inventory_system/widgets/inventory_item.dart';

import 'decrement_item_amount_page.dart';

class InventoryItemPage extends StatefulWidget {
  final String itemCode;

  InventoryItemPage({super.key, required this.itemCode});

  @override
  State<InventoryItemPage> createState() => _InventoryItemPageState();
}

class _InventoryItemPageState extends State<InventoryItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            '${widget.itemCode}',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(13, 13, 13, 1),
        ),
        body: FutureBuilder<InventoryItemModel?>(
            future: InventoryItemDao.findItem(widget.itemCode),
            builder: (context, snapshot) {
              final InventoryItemModel? item = snapshot.data;

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const CenteredCircularProgressIndicator();
                case ConnectionState.waiting:
                  return const CenteredCircularProgressIndicator();
                case ConnectionState.active:
                  return const CenteredCircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData && item != null) {
                    return Column(
                      children: [
                        InventoryItem.fromModel(item),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return IncrementItemAmountPage(
                                            unit: item.unit,
                                            itemCode: item.code);
                                      })).then((value) {
                                    setState(() {

                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 32,
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return DecrementItemAmountPage(
                                            unit: item.unit,
                                            itemCode: item.code);
                                      })).then((value) {
                                    setState(() {

                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 32,
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(title: Text(
                                        'Are you sure you want to delete item ${item
                                            .code} ?'), actions: [
                                      ElevatedButton(onPressed: () {
                                        Navigator.pop(context, false);
                                      }, child: Icon(Icons.close)),
                                      ElevatedButton(onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return FutureBuilder(future: InventoryItemDao.removeInventoryItem(item.code), builder: (context, snapshot) {
                                            switch(snapshot.connectionState) {

                                              case ConnectionState.none:
                                                return CenteredCircularProgressIndicator();
                                              case ConnectionState.waiting:
                                                return CenteredCircularProgressIndicator();
                                              case ConnectionState.active:
                                                return CenteredCircularProgressIndicator();
                                              case ConnectionState.done:
                                                Navigator.pop(context);
                                            }
                                            return Text('Unknown Error');
                                          });
                                        })).then((value) {
                                          Navigator.pop(context, true);
                                        });
                                      }, child: Icon(Icons.check)),
                                    ],);
                                  }).then((value) => {
                                    if(value){
                                      Navigator.pop(context)
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 32,
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue)),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
              }
              return Text('Unknown Error');
            }));
  }
}
