// // import 'package:ecommerce_app_bloc/Models/product.dart';
// import 'dart:developer';

// import 'package:ecommerce_app_bloc/Models/product.dart';
// import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_bloc.dart';
// import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_event.dart';
// import 'package:ecommerce_app_bloc/db/db_code.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddProduct extends StatelessWidget {
//   // const AddProduct({Key? key}) : super(key: key);
//   // final Function callBackcall;

//   const AddProduct({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return _AddProductForm();
//   }
// }

// class _AddProductForm extends StatelessWidget {
//   // final Function callBack;
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();

//   _AddProductForm();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: idController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an ID';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: nameController,
//                 textCapitalization: TextCapitalization.words,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'Price'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a price';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     final int id = int.parse(idController.text);
//                     final String name = nameController.text;
//                     final double price = double.parse(priceController.text);

//                     Product product = Product(
//                       id: id,
//                       name: name,
//                       price: price,
//                     );
//                     final existingProduct =
//                         await ProductDatabase.instance.getProductById(id);
//                     log(existingProduct.toString());
//                     if (existingProduct != null) {
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text(
//                             'Product already exists, try using another ID'),
//                         duration: Duration(seconds: 1),
//                       ));
//                     } else {
//                       final productBloc = BlocProvider.of<PrdBloc>(context);

//                       productBloc.add(AddToPrd(product));
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text('Product Added Successfully'),
//                         duration: Duration(seconds: 1),
//                       ));
//                       log("here fetch");
//                       Navigator.pop(context);
//                     }

//                     idController.clear();
//                     nameController.clear();
//                     priceController.clear();
//                   }
//                 },
//                 child: const Text('Add'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
