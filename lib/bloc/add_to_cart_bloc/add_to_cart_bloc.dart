import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<CartEvent>(_mapEventToState);
  }
  Future<void> _mapEventToState(
      CartEvent event, Emitter<CartState> emit) async {
    if (event is AddToCart) {
      final updatedCart = List<Product>.from(state.cartItems)
        ..add(event.product);
      emit(CartState(updatedCart));
      //apply break point to check the check which item added in the cart
    } else if (event is RemoveFromCart) {
      final updaetCart = List<Product>.from(state.cartItems)
        ..remove(event.product);
      emit(CartState(updaetCart));
    }
  }
}
