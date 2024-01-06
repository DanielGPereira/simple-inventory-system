import 'package:flutter/material.dart';
import 'package:simple_inventory_system/data/inventory_item_dao.dart';
import 'package:simple_inventory_system/models/inventory_item_model.dart';

class CreateNewInventoryItemPage extends StatefulWidget {
  const CreateNewInventoryItemPage({super.key});

  @override
  State<CreateNewInventoryItemPage> createState() =>
      _CreateNewInventoryItemPageState();
}

class _CreateNewInventoryItemPageState
    extends State<CreateNewInventoryItemPage> {

  TextEditingController code = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController storeAddress = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController amount = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Item',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: code,
                      decoration: const InputDecoration(
                          hintText: 'Code',
                         ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: description,
                      decoration: const InputDecoration(
                          hintText: 'Description',
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: storeAddress,
                      decoration: const InputDecoration(
                          hintText: 'Store Address',
                          ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: unit,
                            decoration: const InputDecoration(
                                hintText: 'Unit',
                           ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: amount,
                            decoration: const InputDecoration(
                                hintText: 'Amount',
                              ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 64),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        InventoryItemDao.createInventoryItem(
                            InventoryItemModel(
                                code.text, description.text, unit.text,
                                storeAddress.text, amount: double.parse(amount
                                .text))
                        );
                      },
                      child: const Text(
                        'Create',
                        style: TextStyle(color: Colors.blue),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
