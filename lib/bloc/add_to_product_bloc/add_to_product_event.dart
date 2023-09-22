import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToProduct extends ProductEvent {
  final Product product;
  AddToProduct(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromProduct extends ProductEvent {
  final Product product;
  RemoveFromProduct(this.product);
  @override
  List<Object> get props => [product];
}
