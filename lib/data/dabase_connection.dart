import 'package:simple_inventory_system/data/inventory_item_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {

  DatabaseConnection();

  static Future<Database> getDatabase(String databaseName) async {
    return openDatabase(join(await getDatabasesPath(), databaseName), version: 1,
        onCreate: (db, version) {
      db.execute(InventoryItemDao.tableSql);
    });
  }
}
