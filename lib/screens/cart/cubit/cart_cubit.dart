import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salonapp/screens/cart/data/cart_repository_impl.dart';
import 'package:salonapp/screens/cart/domain/model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  final _cartRepositoryImpl = CartRepositoryImpl();

  void addItem(CartItem item) {
    final items = List<CartItem>.from(state);
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);
    if (existingItemIndex >= 0) {
      final existingItem = items[existingItemIndex];
      items[existingItemIndex] = CartItem(
          id: existingItem.id,
          name: existingItem.name,
          quantity: existingItem.quantity + item.quantity,
          price: existingItem.price,
          discountedPrice: existingItem.discountedPrice);
    } else {
      items.add(item);
    }
    emit(items);
  }

  void removeItem(String itemId) {
    final items = List<CartItem>.from(state);
    final existingItemIndex = items.indexWhere((i) => i.id == itemId);
    if (existingItemIndex >= 0) {
      final existingItem = items[existingItemIndex];
      if (existingItem.quantity > 1) {
        items[existingItemIndex] = CartItem(
            id: existingItem.id,
            name: existingItem.name,
            quantity: existingItem.quantity - 1,
            price: existingItem.price,
            discountedPrice: existingItem.discountedPrice);
      } else {
        items.removeAt(existingItemIndex);
      }
      emit(items);
    }
  }

  void clearCart() {
    emit([]);
  }

  double getTotalAmountMrp() {
    return state.fold(0.0, (total, item) => total + item.price * item.quantity);
  }

  double getTotalAmountWithDiscount() {
    return state.fold(
        0.0, (total, item) => total + item.discountedPrice * item.quantity);
  }

  createCart() async {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
        state.map((e) => {"count": e.quantity, "serviceType": e.id}));

    final result = await _cartRepositoryImpl.createCart(data);

    result.fold((error) {
      print(error);
    }, (successData) {
      try {
        if (successData != null && successData.data['status']) {
          
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
