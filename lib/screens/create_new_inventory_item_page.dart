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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(13, 13, 13, 1),
        title: Text(
          'Create Item',
          style: TextStyle(color: Colors.white),
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
                      decoration: InputDecoration(
                          hintText: 'Code',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: description,
                      decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: storeAddress,
                      decoration: InputDecoration(
                          hintText: 'Store Address',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: unit,
                            decoration: InputDecoration(
                                hintText: 'Unit',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: amount,
                            decoration: InputDecoration(
                                hintText: 'Amount',
                                hintStyle: TextStyle(color: Colors.white)),
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
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.blue),
                      )),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          )
        ],
      ),
    );
  }
}
