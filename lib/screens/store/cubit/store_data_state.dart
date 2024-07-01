part of 'store_data_cubit.dart';

@immutable
sealed class StoreDataState {}

final class StoreDataInitial extends StoreDataState {}

final class StoreDataFetched extends StoreDataState {
  final List<ServiceTypesModel> data;
  StoreDataFetched({required this.data});
}
