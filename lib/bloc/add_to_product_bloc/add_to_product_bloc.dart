import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_Product_bloc/add_to_Product_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_Product_bloc/add_to_Product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState([])) {
    on<ProductEvent>(_mapEventToState);
  }
  Future<void> _mapEventToState(
      ProductEvent event, Emitter<ProductState> emit) async {
    if (event is AddToProduct) {
      final updatedProduct = List<Product>.from(state.productItems)
        ..add(event.product);
      emit(ProductState(updatedProduct));
      //apply break point to check the check which item added in the Product
    } else if (event is RemoveFromProduct) {
      final updaetProduct = List<Product>.from(state.productItems)
        ..remove(event.product);
      emit(ProductState(updaetProduct));
    }
  }
  final List<Product> productList = [
      Product(id: 1, name: 'product1', price: 10),
      Product(id: 2, name: 'product2', price: 20),
      Product(id: 3, name: 'product3', price: 30),
      Product(id: 4, name: 'product4', price: 40),
      Product(id: 5, name: 'product5', price: 50),
    ];
}
