import 'dart:developer';

import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_event.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_state.dart';
import 'package:ecommerce_app_bloc/db/db_code.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PrdBloc extends Bloc<PrdEvent, PrdState> {
  PrdBloc() : super(PrdState([])) {
    on<PrdEvent>(_mapEventToState);
  }
  Future<void> _mapEventToState(PrdEvent event, Emitter<PrdState> emit) async {
    final inst = ProductDatabase();
    if (event is AddToPrd) {
      await inst.createProduct(event.product);
      // final updatedPrd = await ProductDatabase().getAllProducts();
      final updatedPrd = await inst.getAllProducts( );

      emit(PrdState(updatedPrd));
    } else if (event is RemoveFromPrd) {
      // final updaetPrd = List<Product>.from(state.productItems)
      //   ..remove(event.product);

      await inst.deleteProduct(event.product.id,  );
      final updaetPrd = await inst.getAllProducts( );
      emit(PrdState(updaetPrd));

    } else if (event is Fetch) {
      final fin = await inst.getAllProducts( );
      log('${fin.length}');
      emit(PrdState(fin));
      
    } else if (event is UpdatePrd) {
      await inst.updateProduct(event.product,  );
      final fin = await inst.getAllProducts( );

      emit(PrdState(fin));
    }
  }
}
