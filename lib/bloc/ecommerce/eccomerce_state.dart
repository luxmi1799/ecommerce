import 'package:equatable/equatable.dart';

import 'ecommerce_model.dart';

abstract class EcommerceState extends Equatable {}

class InitialState extends EcommerceState {
  @override
  List<Object> get props => [];
}

class LoadingState extends EcommerceState {
  @override
  List<Object> get props => [];
}

class LoadedState extends EcommerceState {
  LoadedState(this.product);

  final List<Products> product;

  @override
  List<Object> get props => [product];
}

class ErrorState extends EcommerceState {
  @override
  List<Object> get props => [];
}
