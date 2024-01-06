import 'dart:async';
import 'dart:ffi';
import 'package:simple_inventory_system/data/dabase_connection.dart';
import 'package:simple_inventory_system/models/inventory_item_model.dart';
import 'package:sqflite/sqflite.dart';

class InventoryItemDao {

  static const tableSql = 'CREATE TABLE $_tableName('
      'code TEXT,'
      ' description TEXT,'
      ' storeAddress TEXT,'
      ' unit TEXT,'
      ' amount DOUBLE)';

  static const String _databaseName = 'InventoryDatabase';
  static const String _tableName = 'InventoryItems';


  static Future createInventoryItem(InventoryItemModel inventoryItemModel) async {
    try{
      print('Creating new item.');
      final Database db = await DatabaseConnection.getDatabase(_databaseName);
      db.insert(_tableName, inventoryItemModel.toMap());

    }catch(ex){
      print(ex);
      return;
    }

  }

  static Future<List<InventoryItemModel>?> getAllInventoryItems() async {
    try{
      final Database db = await DatabaseConnection.getDatabase(_databaseName);
      final List<Map<String, dynamic>> maps = await db.query(_tableName);
      return List.generate(
          maps.length, (index) => InventoryItemModel.fromMap(maps[index]));
    }catch(ex){
      print(ex);
      return null;
    }

  }


  static Future incrementAmountInventoryItem(String itemCode, double increment) async {
    try{
      final InventoryItemModel? item = await findItem(itemCode);

      if(item != null) {
        item.amount += increment;
        item.amount = item.amount < 0 ? 0 : item.amount;

        await updateInventoryItem(item);
      }
    }
    catch(ex){
      print(ex);
    }
  }

  static Future decrementAmountInventoryItem(String itemCode, double decrement) async {
    try{
      final InventoryItemModel? item = await findItem(itemCode);

      if(item != null) {
        item.amount -= decrement;
        item.amount = item.amount < 0 ? 0 : item.amount;

        await updateInventoryItem(item);
      }
    }
    catch(ex){
      print(ex);
    }
  }

  static Future<InventoryItemModel?> findItem(String itemCode) async{
    try{
      final Database db = await DatabaseConnection.getDatabase(_databaseName);
      List<Map<String, Object?>> item = await db.rawQuery('SELECT * FROM $_tableName WHERE code = "$itemCode"');

      print(item);

      if(item.isNotEmpty) {
        return InventoryItemModel.fromMap(item[0]);
      }
      return null;
    }
    catch(ex){
      print(ex);
      return null;
    }

  }

  static Future removeInventoryItem(String code) async {
    try {
      final Database db = await DatabaseConnection.getDatabase(_databaseName);
      db.delete(_tableName, where: 'code = ?', whereArgs: [code]);
      print('removing $code');
    }
    catch (ex){
      print(ex);
      return;
    }
  }

  static Future updateInventoryItem(InventoryItemModel newItem) async {
    try{
      final Database db = await DatabaseConnection.getDatabase(_databaseName);
      return await db.update(_tableName, newItem.toMap(), where: "code = ?", whereArgs: [newItem.code]);
    }
    catch(ex){
      print(ex);
    }

  }



}


