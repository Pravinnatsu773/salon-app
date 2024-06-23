part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileInLoadedState extends ProfileState {
  final UserModel user;

  ProfileInLoadedState({required this.user});
}
