import 'dart:developer';

import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:ecommerce_app_bloc/db/db_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<CartEvent>(_mapEventToState);
  }
  Future<void> _mapEventToState(
      CartEvent event, Emitter<CartState> emit) async {
    final inst = CartDatabase();
    if (event is AddToCart) {
      await inst.createProduct(
        event.product,
      );
      final updatedPrd = await inst.getAllProducts();
      log(updatedPrd.length.toString());
      emit(CartState(updatedPrd));
      // final updatedCart = List<Product>.from(state.cartItems)
      //   ..add(event.product);
      // emit(CartState(updatedCart));
    } else if (event is RemoveFromCart) {
      await inst.deleteProduct(
        event.product.id,
      );
      final updaetPrd = await inst.getAllProducts();
      emit(CartState(updaetPrd));

      // final updaetCart = List<Product>.from(state.cartItems)
      //   ..remove(event.product);
      // emit(CartState(updaetCart));
    } else if (event is CartFetch) {
      final updatedPrd = await inst.getAllProducts();
      emit(CartState(updatedPrd));
    } else if (event is UpdateCart) {
      await inst.updateProduct(event.product);
      final updatedPrd = await inst.getAllProducts();
       emit(CartState(updatedPrd));
    }
  }
}
// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartState([])) {
//     on<CartEvent>(_mapEventToState);
//   }
//   Future<void> _mapEventToState(
//       CartEvent event, Emitter<CartState> emit) async {
//     if (event is AddToCart) {
//       await CartDatabase().createProduct(event.product);
//       final updatedPrd = await CartDatabase().getAllProducts();
//       log(updatedPrd.length.toString());
//       emit(CartState(updatedPrd));
//       // final updatedCart = List<Product>.from(state.cartItems)
//       //   ..add(event.product);
//       // emit(CartState(updatedCart));
//     } else if (event is RemoveFromCart) {
//       await CartDatabase().deleteProduct(event.product.id);
//       final updaetPrd = await CartDatabase().getAllProducts();
//       emit(CartState(updaetPrd));

//       // final updaetCart = List<Product>.from(state.cartItems)
//       //   ..remove(event.product);
//       // emit(CartState(updaetCart));
//     } else if (event is CartFetch) {
//       final updatedPrd = await CartDatabase().getAllProducts();
//       emit(CartState(updatedPrd));
//     }
//   }
// }
