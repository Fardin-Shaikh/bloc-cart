// class Product {
//   final int id;
//   final String name;
//   final double price;
//   int quantity;

//   Product(
//       {required this.id,
//       required this.name,
//       required this.price,
//       this.quantity = 0});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'price': price,
//       'quantity': quantity,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'],
//       name: map['name'],
//       price: map['price'],
//       quantity: map['quantity'],
//     );
//   }
// }
class Product {
  final int id;
  final String name;
  final double price;
  int quantity;
  int position;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      this.position = 0,
      this.quantity = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'position': position,
    };
  }

  // Map<String, dynamic> toMap() {
  //   final map = {
  //     'id': id,
  //     'name': name,
  //     'price': price,
  //     'quantity': quantity,
  //   };

  //   if (position != null) {
  //     map['position'] = position!;
  //   }

  //   return map;
  // }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      position: map['position'],
    );
  }
}
