part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

class LoadingUsersState extends UsersState {}

class ErrorUsersState extends UsersState {}

class SuccessUsersState extends UsersState {}
