part of 'asks_cubit.dart';

@immutable
sealed class AsksState {}

final class AsksInitial extends AsksState {}

class LoadingAsksState extends AsksState {}

class SuccessAsksState extends AsksState {}

class ErrorAsksState extends AsksState {}

class LoadingReplyAsksState extends AsksState {}

class SuccessReplyAsksState extends AsksState {}

class ErrorReplyAsksState extends AsksState {}
