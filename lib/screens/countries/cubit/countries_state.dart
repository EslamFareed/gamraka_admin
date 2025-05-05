part of 'countries_cubit.dart';

@immutable
sealed class CountriesState {}

final class CountriesInitial extends CountriesState {}


class LoadingCountriesState extends CountriesState{}
class SuccessCountriesState extends CountriesState{}
class ErrorCountriesState extends CountriesState{}