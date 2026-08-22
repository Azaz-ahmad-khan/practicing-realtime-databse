class Item {
  String? id;
  final String name;
  final int quantity;
  final bool isbought;
  final DateTime addedAt;
  Item({
    this.id,
    required this.name,
    required this.quantity,
    required this.addedAt,
    required this.isbought,
  });
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'],
      quantity: map['quantity'],
      addedAt: map['addedAt'],
      isbought: map['isbought'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'addedAt': addedAt,
      'isbought': isbought,
    };
  }
}
