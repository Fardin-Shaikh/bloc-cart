import 'dart:developer';

import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_bloc.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_state.dart';
import 'package:ecommerce_app_bloc/db/db_code.dart';
import 'package:ecommerce_app_bloc/screeens/cart_list_screen.dart';
import 'package:ecommerce_app_bloc/screeens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (_) => const AddUpdateProduct()))
                      .whenComplete(
                          () => BlocProvider.of<PrdBloc>(context).add(Fetch()));
                  // .then((value) => PrdBloc()..add(Fetch()));
                },
                icon: const Icon(Icons.add)),
            BlocBuilder<CartBloc, CartState>(
                bloc: BlocProvider.of<CartBloc>(context)..add(CartFetch()),
                builder: (context, state) {
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
        body:
            //BLOC COSUMNER CODE
            //     BlocConsumer<PrdBloc, PrdState>(
            //   listener: (context, state) {
            //     BlocProvider.of<PrdBloc>(context).add(Fetch());
            //     // state.maybeWhen(
            //     //     onTap: (count, color) {
            //     //       counter = count;
            //     //       count_list.add({'count': count, 'color': color});
            //     //       // generate == false ? :
            //     //     },
            //     //     orElse: () {});
            //   },
            //   builder: (context, state) {
            //     List<Product> lis = state.productItems
            //       ..sort((a, b) => a.position.compareTo(b.position));
            //     // List<Widget> test = (state.productItems
            //     //   ..sort((a, b) => a.position.compareTo(b.position))
            //     //   ..map((e) {
            //     //     return Container();
            //     //   }).toList()).cast<Widget>();
            //     // products.sort((a, b) => a.name.compareTo(b.name));
            //     return ReorderableListView(
            //       onReorder: (oldIndex, newIndex) async {
            //         // Update the position of the dragged product in the list
            //         final productToMove = lis[oldIndex];
            //         final newPosition =
            //             newIndex < oldIndex ? newIndex : newIndex - 1;
            //         lis.removeAt(oldIndex);
            //         lis.insert(newPosition, productToMove);
            //         log("in reordering ");
            //         // Update the positions of all products in the list
            //         for (int i = 0; i < lis.length; i++) {
            //           lis[i].position = i;
            //           await ProductDatabase().updateProductPosition(lis[i].id, i);
            //         }
            //         // BlocProvider.of<PrdBloc>(context).add(Fetch());
            //       },
            //       children: (lis.map((product) {
            //         final firstLetter = product.name[0].toUpperCase();
            //         final lastLetter =
            //             product.name[product.name.length - 1].toUpperCase();
            //         return Dismissible(
            //           key: Key(product.id.toString()),
            //           direction: DismissDirection.horizontal,
            //           onDismissed: (direction) {
            //             final prdbloc = BlocProvider.of<PrdBloc>(context);
            //             prdbloc
            //                 .add(RemoveFromPrd(product)); //to find the product bloc
            //             final cartBloc = BlocProvider.of<CartBloc>(context);
            //             cartBloc.add(RemoveFromCart(product));
            //             //this is used to remove the product form the cart if the product is present in the cart
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(
            //                 content: Text('Product ${product.name} deleted'),
            //               ),
            //             );
            //           },
            //           background: Container(
            //             color: Colors.red,
            //             alignment: Alignment.centerLeft,
            //             child: const Icon(
            //               Icons.delete,
            //               color: Colors.white,
            //             ),
            //           ),
            //           child: ListTile(
            //             key: ValueKey(product.id),
            //             title: Text(product.name),
            //             subtitle: Text('\$${product.price}'),
            //             onTap: () {
            //               Navigator.of(context).push(MaterialPageRoute(
            //                   builder: (_) => AddUpdateProduct(
            //                         prd: product,
            //                       )));
            //             },
            //             leading: CircleAvatar(
            //               child: Text(firstLetter + lastLetter),
            //             ),
            //             trailing: IconButton(
            //                 onPressed: () {
            //                   final cartBloc = BlocProvider.of<CartBloc>(context);
            //                   final cartItems = cartBloc.state.cartItems;
            //                   if (cartItems.any((item) => item.id == product.id)) {
            //                     ScaffoldMessenger.of(context)
            //                         .showSnackBar(const SnackBar(
            //                       content: Text('Product already added to Cart'),
            //                       duration: Duration(seconds: 1),
            //                     ));
            //                   } else {
            //                     cartBloc.add(AddToCart(product));
            //                     ScaffoldMessenger.of(context)
            //                         .showSnackBar(const SnackBar(
            //                       content: Text('Product added to Cart'),
            //                       duration: Duration(seconds: 1),
            //                     ));
            //                   }
            //                 },
            //                 icon: const Icon(Icons.add_shopping_cart_outlined)),
            //           ),
            //         );
            //       }).toList()),
            //     );
            //   },
            // ));
            BlocBuilder<PrdBloc, PrdState>(
          bloc: BlocProvider.of<PrdBloc>(context)..add(Fetch()),
          // buildWhen: (previous, current) {
          //   // The bloc will only rebuild if the number of items or the value contents change.
          //   // Changes to the order of the items doesn't trigger a rebuild.
          //   final sortedPreviousItems = [...previous.productItems]
          //     ..sort((a, b) => a.id.compareTo(b.id));
          //   final sortedCurrentItems = [...current.productItems]
          //     ..sort((a, b) => a.id.compareTo(b.id));
          //   if (!listEquals(sortedPreviousItems, sortedCurrentItems)) {
          //     log("true value");
          //     BlocProvider.of<PrdBloc>(context).add(Fetch());
          //     return true;
          //   }
          //   log("fasle value");
          //   return false;
          // },
          builder: (context, state) {
            List<Product> lis = state.productItems
              ..sort((a, b) => a.position.compareTo(b.position));
            // List<Product> lis = state.productItems
            //   ..sort((a, b) {
            //     if (a.position == null && b.position == null) {
            //       return 0;
            //     }
            //     return a.position!.compareTo(b.position as num);
            //   });
            // ..sort((a, b) => a.position!.compareTo(b.position as num));
            // List<Widget> test = state.productItems
            //   ..map((e) {
            //     return Container();
            //   })
            //   ..sort((a, b) => a.position.compareTo(b.position));
            // products.sort((a, b) => a.name.compareTo(b.name));
            if (lis.isEmpty) {
              return const Center(
                child: Text(" No product ! Add new product "),
              );
            }
            return ReorderableListView.builder(
              onReorder: (oldIndex, newIndex) async {
                // Update the position of the dragged product in the list
                final productToMove = lis[oldIndex];
                final newPosition =
                    newIndex < oldIndex ? newIndex : newIndex - 1;
                lis.removeAt(oldIndex);
                lis.insert(newPosition, productToMove);
                log("in reordering ");
                // Update the positions of all products in the list
                for (int i = 0; i < lis.length; i++) {
                  lis[i].position = i;
                  await ProductDatabase().updateProductPosition(lis[i].id, i);
                }

                // BlocProvider.of<PrdBloc>(context).add(Fetch());
              },
              itemCount: lis.length,
              itemBuilder: (BuildContext context, int index) {
                final product = lis[index];
                final firstLetter = product.name[0].toUpperCase();
                final lastLetter =
                    product.name[product.name.length - 1].toUpperCase();
                return Dismissible(
                  key: Key(product.id.toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    final prdbloc = BlocProvider.of<PrdBloc>(context);
                    prdbloc
                        .add(RemoveFromPrd(product)); //to find the product bloc

                    final cartBloc = BlocProvider.of<CartBloc>(context);
                    cartBloc.add(RemoveFromCart(product));
                    //this is used to remove the product form the cart if the product is present in the cart

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Product ${product.name} deleted'),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    key: ValueKey(product.id),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AddUpdateProduct(
                                prd: product, 
                              )));
                    },
                    leading: CircleAvatar(
                      child: Text(firstLetter + lastLetter),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          final cartBloc = BlocProvider.of<CartBloc>(context);
                          final cartItems = cartBloc.state.cartItems;
                          if (cartItems.any((item) => item.id == product.id)) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Product already added to Cart'),
                              duration: Duration(seconds: 1),
                            ));
                          } else {
                            cartBloc.add(AddToCart(product));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Product added to Cart'),
                              duration: Duration(seconds: 1),
                            ));
                          }
                        },
                        icon: const Icon(Icons.add_shopping_cart_outlined)),
                  ),
                );
              },
            );
            //!!!ALWAYS REMEMBER WHEN THERE IS UI RELATETD STATE UPDAET FROM A LIBARRY(HERE IS REORDERABLE LIST ) IT HSOULD BE IN A BUILDER
          },
        ));
  }

  Widget listViewSWap(List<Product> lis) {
    //  List<Product> products = state.productItems;
    //       products.sort((a, b) => a.name.compareTo(b.name));
    if (lis.isEmpty) {
      return const Center(
        child: Text(" No product ! Add new product "),
      );
    } else {
      return ListView.builder(
          itemCount: lis.length,
          itemBuilder: (context, index) {
            final product = lis[index];
            final firstLetter = product.name[0].toUpperCase();
            final lastLetter =
                product.name[product.name.length - 1].toUpperCase();
            return Dismissible(
              key: Key(product.id.toString()),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                final prdbloc = BlocProvider.of<PrdBloc>(context);
                prdbloc.add(RemoveFromPrd(product)); //to find the product bloc

                final cartBloc = BlocProvider.of<CartBloc>(context);
                cartBloc.add(RemoveFromCart(product));
                //this is used to remove the product form the cart if the product is present in the cart

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product ${product.name} deleted'),
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: ListTile(
                key: ValueKey(product.id),
                title: Text(product.name),
                subtitle: Text('\$${product.price}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddUpdateProduct(
                            prd: product,
                          )));
                },
                leading: CircleAvatar(
                  child: Text(firstLetter + lastLetter),
                ),
                trailing: IconButton(
                    onPressed: () {
                      final cartBloc = BlocProvider.of<CartBloc>(context);
                      final cartItems = cartBloc.state.cartItems;
                      if (cartItems.any((item) => item.id == product.id)) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Product already added to Cart'),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        cartBloc.add(AddToCart(product));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Product added to Cart'),
                          duration: Duration(seconds: 1),
                        ));
                      }
                    },
                    icon: const Icon(Icons.add_shopping_cart_outlined)),
              ),
            );
          });
    }
  }
}

// BlocBuilder<PrdBloc, PrdState>(
//         builder: (context, state) {
//           if (state.productItems.isEmpty) {
//             return const Center(
//               child: Text(" No product ! Add new product "),
//             );
//           } else {
//             return ListView.builder(
//                 itemCount: state.productItems.length,
//                 itemBuilder: (context, index) {
//                   final product = state.productItems[index];

//                   return ListTile(
//                     title: Text(product.name),
//                     subtitle: Text('\$${product.price}'),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (_) => UpdateProduct(
//                                 prd: product,
//                               )));
//                     },
//                     leading: IconButton(
//                         onPressed: () {
//                           final prdbloc = context.read<PrdBloc>();
//                           prdbloc.add(RemoveFromPrd(
//                               product)); //to find the product bloc

//                           final cartBloc = BlocProvider.of<CartBloc>(context);
//                           cartBloc.add(RemoveFromCart(product));
//                           //this is used to remove the product form the cart if the product is present in the cart
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(const SnackBar(
//                             content: Text('Product Removed Sucessfully!'),
//                             duration: Duration(seconds: 1),
//                           ));
//                         },
//                         icon: const Icon(Icons.clear)),
//                     trailing: IconButton(
//                         onPressed: () {
//                           final cartBloc = context.read<CartBloc>();
//                           final cartItems = cartBloc.state.cartItems;
//                           if (cartItems.any((item) => item.id == product.id)) {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text('Product already added to Cart'),
//                               duration: Duration(seconds: 1),
//                             ));
//                           } else {
//                             cartBloc.add(AddToCart(product));
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text('Product added to Cart'),
//                               duration: Duration(seconds: 1),
//                             ));
//                           }
//                         },
//                         icon: const Icon(Icons.add_shopping_cart_outlined)),
//                   );
//                 });
//           }
//         },
//       ),

// FutureBuilder<List<Product>>(
//         future: ProductDatabase.instance.getAllProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No products available.'));
//           } else {
//             final products = snapshot.data!;
//             return BlocBuilder<PrdBloc, PrdState>(
//               builder: (context, state) {
//                 if (products.isEmpty) {
//                   return const Center(
//                     child: Text(" No product ! Add new product "),
//                   );
//                 } else {
//                   return ListView.builder(
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         final product = products[index];

//                         return ListTile(
//                           title: Text(product.name),
//                           subtitle: Text('\$${product.price}'),
//                           leading: IconButton(
//                               onPressed: () {
//                                 final prdbloc = context.read<PrdBloc>();
//                                 prdbloc.add(RemoveFromPrd(
//                                     product)); //to find the product bloc

//                                 final cartBloc =
//                                     BlocProvider.of<CartBloc>(context);
//                                 cartBloc.add(RemoveFromCart(product));
//                                 //this is used to remove the product form the cart if the product is present in the cart
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(const SnackBar(
//                                   content: Text('Product Removed Sucessfully!'),
//                                   duration: Duration(seconds: 1),
//                                 ));
//                               },
//                               icon: const Icon(Icons.clear)),
//                           trailing: IconButton(
//                               onPressed: () {
//                                 final cartBloc = context.read<CartBloc>();
//                                 final cartItems = cartBloc.state.cartItems;
//                                 if (cartItems
//                                     .any((item) => item.id == product.id)) {
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(const SnackBar(
//                                     content:
//                                         Text('Product already added to Cart'),
//                                     duration: Duration(seconds: 1),
//                                   ));
//                                 } else {
//                                   cartBloc.add(AddToCart(product));
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(const SnackBar(
//                                     content: Text('Product added to Cart'),
//                                     duration: Duration(seconds: 1),
//                                   ));
//                                 }
//                               },
//                               icon:
//                                   const Icon(Icons.add_shopping_cart_outlined)),
//                         );
//                       });
//                 }
//               },
//             );
//           }
//         },
//       ),

// BlocBuilder<PrdBloc, PrdState>(
//           builder: (context, state) {
//             if (state is LoadState) {
//               return FutureBuilder<List<Product>>(
//                   future: ProductDatabase.instance.getAllProducts(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                           child: Text('No products available.'));
//                     } else {
//                       return const Text("haev some");
//                     }
//                   });
//             } else {
//               final products = state.productItems;
//               if (products.isEmpty) {
//                 return const Center(
//                   child: Text(" No product ! Add new product "),
//                 );
//               } else {
//                 return ListView.builder(
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];

//                       return ListTile(
//                         title: Text(product.name),
//                         subtitle: Text('\$${product.price}'),
//                         leading: IconButton(
//                             onPressed: () {
//                               final prdbloc = context.read<PrdBloc>();
//                               prdbloc.add(RemoveFromPrd(
//                                   product)); //to find the product bloc

//                               final cartBloc =
//                                   BlocProvider.of<CartBloc>(context);
//                               cartBloc.add(RemoveFromCart(product));
//                               //this is used to remove the product form the cart if the product is present in the cart
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(const SnackBar(
//                                 content: Text('Product Removed Sucessfully!'),
//                                 duration: Duration(seconds: 1),
//                               ));
//                             },
//                             icon: const Icon(Icons.clear)),
//                         trailing: IconButton(
//                             onPressed: () {
//                               final cartBloc = context.read<CartBloc>();
//                               final cartItems = cartBloc.state.cartItems;
//                               if (cartItems
//                                   .any((item) => item.id == product.id)) {
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(const SnackBar(
//                                   content:
//                                       Text('Product already added to Cart'),
//                                   duration: Duration(seconds: 1),
//                                 ));
//                               } else {
//                                 cartBloc.add(AddToCart(product));
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(const SnackBar(
//                                   content: Text('Product added to Cart'),
//                                   duration: Duration(seconds: 1),
//                                 ));
//                               }
//                             },
//                             icon: const Icon(Icons.add_shopping_cart_outlined)),
//                       );
//                     });
//               }
//             }
//           },
//         )
