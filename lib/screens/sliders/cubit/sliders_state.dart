part of 'sliders_cubit.dart';

@immutable
sealed class SlidersState {}

final class SlidersInitial extends SlidersState {}


class LoadingSlidersState extends SlidersState{}
class SuccessSlidersState extends SlidersState{}
class ErrorSlidersState extends SlidersState{}


