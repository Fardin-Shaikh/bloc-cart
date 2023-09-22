import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:ecommerce_app_bloc/screeens/add_product_screen.dart';
import 'package:ecommerce_app_bloc/screeens/cart_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductlistsLreeSState();
}

class _ProductlistsLreeSState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Product> productList = [
      Product(id: 1, name: 'product1', price: 10),
      Product(id: 2, name: 'product2', price: 20),
      Product(id: 3, name: 'product3', price: 30),
      Product(id: 4, name: 'product4', price: 40),
      Product(id: 5, name: 'product5', price: 50),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AddProduct()));
              },
              icon: const Icon(Icons.add)),
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            int count = state.cartItems.length;
            return Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const CartScreen()));
                    },
                    icon: const Icon(Icons.shopping_cart_outlined)),
                count == 0
                    ? Container()
                    : Positioned(
                        child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        constraints: const BoxConstraints(
                          minHeight: 15,
                          minWidth: 10,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ))
              ],
            );
          }),
        ],
      ),
      body: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final product = productList[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
              trailing: IconButton(
                  onPressed: () {
                    final cartBloc = BlocProvider.of<CartBloc>(context);
                    final cartItems = cartBloc.state.cartItems;
                    if (cartItems.any((item) => item.id == product.id)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Product already added to Cart'),
                        duration: Duration(seconds: 1),
                      ));
                    } else {
                      cartBloc.add(AddToCart(product));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Product added to Cart'),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart_outlined)),
            );
          }),
    );
  }
}
