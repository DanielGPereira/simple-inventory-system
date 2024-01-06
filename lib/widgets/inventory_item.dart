import 'package:flutter/material.dart';
import 'package:simple_inventory_system/models/inventory_item_model.dart';
import 'package:simple_inventory_system/screens/inventory_item_page.dart';

class InventoryItem extends StatelessWidget {
  final String code;
  final String description;
  final String unit;
  final String storeAddress;
  final double amount;

  Function? onPop;

  InventoryItem(
      {super.key,
      required this.code,
      required this.description,
      required this.unit,
      required this.storeAddress,
      required this.amount,
      this.onPop});

  static InventoryItem fromModel(InventoryItemModel model, {onPop}){

    return InventoryItem(code: model.code,
        description: model.description, unit: model.unit,
        storeAddress: model.storeAddress, amount: model.amount, onPop: onPop,);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell( onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return InventoryItemPage(itemCode: code);
        })).then((value) {
          onPop!();
        });
      },
        child: SizedBox(
          height: 150,
          child: Stack(
            children: [
              Container(
                color: const Color.fromRGBO(13, 13, 13, 1),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    color: Colors.blue,
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        code,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.blue))),
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            storeAddress,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            '${amount} ${unit}',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
