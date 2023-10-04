import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
  @override
  List<Object> get props => [product];
}
class UpdateCart extends CartEvent {
  final Product product;
  UpdateCart(this.product);
  @override
  List<Object> get props => [product];
}
class CartFetch extends CartEvent {
  
}
