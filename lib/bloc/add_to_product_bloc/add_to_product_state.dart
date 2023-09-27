import 'package:ecommerce_app_bloc/Models/product.dart';
import 'package:equatable/equatable.dart';

// abstract class AllStates extends Equatable {
//   @override
//   List<Object> get props => [];
// }


// class PrdState extends AllStates {
//   final List<Product> productItems;
//   PrdState(this.productItems);
// }

// class LoadState extends AllStates {
//   final List<Product> productItems;
//   LoadState(this.productItems);
// }

// class InitialState extends AllStates {}
class PrdState  {
  final List<Product> productItems;
  PrdState(this.productItems);
}

// class LoadState {
//   final List<Product> productItems;
//   LoadState(this.productItems);
// }
