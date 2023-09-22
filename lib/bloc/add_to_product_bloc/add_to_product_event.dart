import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:equatable/equatable.dart';

abstract class PrdEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToPrd extends PrdEvent {
  final Product product;
  AddToPrd(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromPrd extends PrdEvent {
  final Product product;
  RemoveFromPrd(this.product);
  @override
  List<Object> get props => [product];
}
