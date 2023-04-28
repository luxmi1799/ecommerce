import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/ecommerce/eccomerce_state.dart';

import 'ecommerce_repository.dart';

class EcommerceCubit extends Cubit<EcommerceState> {
  EcommerceCubit({required this.repository}) : super(InitialState()) {
    getTrendingMovies();
  }

  final EcommerceRepository repository;

  void getTrendingMovies() async {
    try {
      emit(LoadingState());
      final movies = await repository.getProducts();
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
