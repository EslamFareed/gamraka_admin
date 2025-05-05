part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}


class LoadingCategoriesState extends CategoriesState{}
class SuccessCategoriesState extends CategoriesState{}
class ErrorCategoriesState extends CategoriesState{}