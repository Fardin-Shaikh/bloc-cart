import 'dart:developer';

import 'package:ecommerce_app_bloc/Models/product.dart';

import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_state.dart';
import 'package:ecommerce_app_bloc/db/db_code.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PrdBloc extends Bloc<PrdEvent, PrdState> {
  PrdBloc() : super(PrdState([])) {
    on<PrdEvent>(_mapEventToState);
  }
  Future<void> _mapEventToState(PrdEvent event, Emitter<PrdState> emit) async {
    if (event is AddToPrd) {
      // final updatedPrd = List<Product>.from(state.productItems)
      //   ..add(event.product);
      // emit(PrdState(updatedPrd));
      await ProductDatabase.instance.createProduct(event.product);
      final updatedPrd = await ProductDatabase.instance.getAllProducts();

      emit(PrdState(updatedPrd));
      //apply break point to check the check which item added in the Prd
    } else if (event is RemoveFromPrd) {
      // final updaetPrd = List<Product>.from(state.productItems)
      //   ..remove(event.product);

      await ProductDatabase.instance.deleteProduct(event.product.id);
      final updaetPrd = await ProductDatabase.instance.getAllProducts();
      emit(PrdState(updaetPrd));
    } else if (event is Fetch) {

      final fin = await ProductDatabase.instance.getAllProducts();
      log('${fin.length}');
      emit(PrdState(fin));
    } else if (event is UpdatePrd) {
      await ProductDatabase.instance.updateProduct(event.product);
      final fin = await ProductDatabase.instance.getAllProducts();

      emit(PrdState(fin));
    }
  }
}
