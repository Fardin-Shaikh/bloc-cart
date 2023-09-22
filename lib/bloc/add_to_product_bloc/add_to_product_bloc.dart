import 'package:ecommerce_app_bloc/Models/product.dart';

import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrdBloc extends Bloc<PrdEvent, PrdState> {
  PrdBloc() : super(PrdState([])) {
    on<PrdEvent>(_mapEventToState);
  }
  Future<void> _mapEventToState(PrdEvent event, Emitter<PrdState> emit) async {
    if (event is AddToPrd) {
      final updatedPrd = List<Product>.from(state.productItems)
        ..add(event.product);
      emit(PrdState(updatedPrd));
      //apply break point to check the check which item added in the Prd
    } else if (event is RemoveFromPrd) {
      final updaetPrd = List<Product>.from(state.productItems)
        ..remove(event.product);
      emit(PrdState(updaetPrd));
      
      
    }
  }
  //   final List<Product> productList = [
  //   Product(id: 1, name: 'product1', price: 10),
  //   Product(id: 2, name: 'product2', price: 20),
  //   Product(id: 3, name: 'product3', price: 30),
  //   Product(id: 4, name: 'product4', price: 40),
  //   Product(id: 5, name: 'product5', price: 50),
  // ];
}







