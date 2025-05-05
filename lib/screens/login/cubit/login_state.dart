part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


class LoadingLoginAdminState extends LoginState{}
class SuccessLoginAdminState extends LoginState{}
class ErrorLoginAdminState extends LoginState{}



class LoadingLoginUniversityState extends LoginState{}
class SuccessLoginUniversityState extends LoginState{}
class ErrorLoginUniversityState extends LoginState{}