part of 'routes_cubit.dart';

@immutable
sealed class RoutesState {}

final class RoutesInitial extends RoutesState {}

class StartChooseCountryState extends RoutesState {}
class EndChooseCountryState extends RoutesState {}


class LoadingRoutesState extends RoutesState {}

class SuccessRoutesState extends RoutesState {}

class ErrorRoutesState extends RoutesState {}
