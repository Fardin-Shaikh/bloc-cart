import 'dart:developer';

import 'package:ecommerce_app_bloc/Models/product.dart';
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
    if (event is AddToCart) {
      await CartDatabase.instance.createProduct(event.product);
      final updatedPrd = await CartDatabase.instance.getAllProducts();
      log(updatedPrd.length.toString());
      emit(CartState(updatedPrd));
      // final updatedCart = List<Product>.from(state.cartItems)
      //   ..add(event.product);
      // emit(CartState(updatedCart));
    } else if (event is RemoveFromCart) {
      await CartDatabase.instance.deleteProduct(event.product.id);
      final updaetPrd = await CartDatabase.instance.getAllProducts();
      emit(CartState(updaetPrd));

      // final updaetCart = List<Product>.from(state.cartItems)
      //   ..remove(event.product);
      // emit(CartState(updaetCart));
    } else if (event is CartFetch) {
      final updatedPrd = await CartDatabase.instance.getAllProducts();
      emit(CartState(updatedPrd));
    }
  }
}
