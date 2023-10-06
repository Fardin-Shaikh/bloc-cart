import 'dart:developer';

import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_bloc.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_event.dart';
import 'package:ecommerce_app_bloc/db/db_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateProduct extends StatefulWidget {
  final Product? prd; // add nullable
  const AddUpdateProduct({super.key, this.prd});

  @override
  State<AddUpdateProduct> createState() => _AddUpdateProductState();
}

class _AddUpdateProductState extends State<AddUpdateProduct> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    if (widget.prd != null) {
      idController.text = "${widget.prd!.id}";
      nameController.text = widget.prd!.name;
      priceController.text = "${widget.prd!.price}";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.prd != null
            ? const Text('Update Product')
            : const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  readOnly: widget.prd != null,
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final int id = int.parse(idController.text);
                      final String name = nameController.text;
                      final double price = double.parse(priceController.text);
                      // int highestPosition =
                      //     await ProductDatabase().getHighestPosition();

                      Product product = Product(
                        id: id,
                        name: name,
                        price: price,
                      );
                      // Product product = Product(
                      //     id: id, name: name, price: price, position: id + 1);
                      if (widget.prd != null) {
                        //UPDATE PRODUCT CODE
                        final productBloc = BlocProvider.of<PrdBloc>(context);
                        final cartBloc = BlocProvider.of<CartBloc>(context);

                        productBloc.add(UpdatePrd(product));
                        cartBloc.add(UpdateCart(product));

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Product Updated Successfully'),
                          duration: Duration(seconds: 1),
                        ));
                        Navigator.pop(context);
                      } else {
                        //ADD PRODUCT CODE

                        // final checklist = PrdBloc().state.productItems;
                        // if (checklist
                        //     .any((element) => element.id == product.id)) {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //     content: Text(
                        //         'Product already exists, try using another ID'),
                        //     duration: Duration(seconds: 1),
                        //   ));
                        // } else {
                        //   final productBloc = BlocProvider.of<PrdBloc>(context);

                        //   productBloc.add(AddToPrd(product));
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //     content: Text('Product Added Successfully'),
                        //     duration: Duration(seconds: 1),
                        //   ));
                        //   log("here fetch");
                        //   Navigator.pop(context);
                        // }
                        final existingProduct =
                            await ProductDatabase().getProductById(id);
                        // await ProductDatabase.instance.getProductById(id);
                        log(existingProduct.toString());
                        if (existingProduct != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Product already exists, try using another ID'),
                            duration: Duration(seconds: 1),
                          ));
                        } else {
                          final productBloc = BlocProvider.of<PrdBloc>(context);
                          ProductDatabase().checkDatabaseVersion();
                          //  await ProductDatabase().updateProductPosition(product.id, 0);
                          productBloc.add(AddToPrd(product));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Product Added Successfully'),
                            duration: Duration(seconds: 1),
                          ));
                          log("here fetch");
                          Navigator.pop(context);
                        }
                      }

                      idController.clear();
                      nameController.clear();
                      priceController.clear();
                    }
                  },
                  child: widget.prd != null
                      ? const Text('Update Product')
                      : const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
