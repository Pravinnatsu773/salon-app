part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded({required this.items});
}
