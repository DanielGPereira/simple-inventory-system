class InventoryItemModel {
   String code;
   String description;
   String unit;
   String storeAddress;

   double amount;
   InventoryItemModel(this.code, this.description, this.unit, this.storeAddress,
      {this.amount = 0});

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': description,
      'unit': unit,
      'storeAddress': storeAddress,
      'amount': amount
    };
  }

  static InventoryItemModel fromMap(Map<String, dynamic> map) {
    return InventoryItemModel(
        map['code'], map['description'], map['unit'], map['storeAddress'],
        amount: map['amount']);
  }


}
