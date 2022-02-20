import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshflow_test/domain/cart_item.dart';
import 'package:freshflow_test/services/cart_service.dart';

abstract class CartCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartCubitStateLoading extends CartCubitState {}

class CartCubitStateError extends CartCubitState {}

class CartCubitStateSet extends CartCubitState {
  final List<CartItem> cartItems;

  CartCubitStateSet(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}

class CartCubit extends Cubit<CartCubitState> {
  final BaseCartService cartService;

  CartCubit(this.cartService) : super(CartCubitStateLoading());

  void fetchCart() async {
    emit(CartCubitStateLoading());
    try {
      final List<CartItem> items = await cartService.getAllCartItems();
      if (items.isNotEmpty) {
        emit(CartCubitStateSet(items));
      } else {
        emit(CartCubitStateError());
      }
    } catch (e) {
      emit(CartCubitStateError());
    }
  }
}
