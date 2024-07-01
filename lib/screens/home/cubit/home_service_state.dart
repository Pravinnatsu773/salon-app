part of 'home_service_cubit.dart';

@immutable
sealed class HomeServiceState {}

final class HomeServiceInitial extends HomeServiceState {}

final class HomeServiceDataFetched extends HomeServiceState {
  final List<ServiceTypesModel> trending;
  final List<ServiceTypesModel> recommended;
  final List<ServiceTypesModel> popular;

  HomeServiceDataFetched(
      {required this.trending,
      required this.recommended,
      required this.popular});
}
