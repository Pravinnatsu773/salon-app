import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salonapp/screens/address/domain/model/address_model.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<List<AddressModel>> {
  AddressCubit() : super([]);
  getAddress() {
    final items = List<AddressModel>.from(state);

    emit(state);
  }

  createAddress(String title, String address) {
    final items = List<AddressModel>.from(state);

    emit([
      ...items,
      AddressModel(
          id: items.length.toString(),
          title: title,
          address: address,
          isSelected: false)
    ]);
  }

  selectAddress(String id, bool value) {
    final items = List<AddressModel>.from(state);
    for (var model in items) {
      if (model.id == id) {
        model.isSelected = value;
        break;
      }
    }
    emit(items);
  }
}
