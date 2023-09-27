import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_bloc.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProduct extends StatefulWidget {
  final Product prd;
  const UpdateProduct({super.key, required this.prd});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    idController.text = "${widget.prd.id}";
    nameController.text = widget.prd.name;
    priceController.text = "${widget.prd.price}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                readOnly: true,
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

                    Product product = Product(
                      id: id,
                      name: name,
                      price: price,
                    );

                    final productBloc = context.read<PrdBloc>();
                    // final productList = productBloc.state.productItems;

                    productBloc.add(UpdatePrd(product));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Product Added Successfully'),
                      duration: Duration(seconds: 1),
                    ));
                    Navigator.pop(context);

                    idController.clear();
                    nameController.clear();
                    priceController.clear();
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
