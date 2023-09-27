import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:equatable/equatable.dart';

abstract class PrdEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// class FeatchPrd extends PrdEvent {

//   FeatchPrd();
//   @override
//   List<Object> get props => [];
// }
class AddToPrd extends PrdEvent {
  final Product product;
  AddToPrd(this.product);
  @override
  List<Object> get props => [product];
}

class Fetch extends PrdEvent {
  Fetch();
  @override
  List<Object> get props => [];
}

class RemoveFromPrd extends PrdEvent {
  final Product product;
  RemoveFromPrd(this.product);
  @override
  List<Object> get props => [product];
}

class UpdatePrd extends PrdEvent {
  final Product product;
  UpdatePrd(this.product);
  @override
  List<Object> get props => [product];
}
