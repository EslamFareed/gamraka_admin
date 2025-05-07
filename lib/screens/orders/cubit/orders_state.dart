part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

 class LoadingGetOrdersState extends OrdersState {}
 class SuccessGetOrdersState extends OrdersState {}
 class ErrorGetOrdersState extends OrdersState {}
 
