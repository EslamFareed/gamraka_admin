import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/order_model.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  static OrdersCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<OrderModel> orders = [];

  void getOrders() async {
    emit(LoadingGetOrdersState());

    try {
      var data = await firestore.collection("orders").get();

      orders = data.docs.map((e) => OrderModel.fromJson(e)).toList();

      emit(SuccessGetOrdersState());
    } catch (e) {
      emit(ErrorGetOrdersState());
    }
  }

  void cancelOrder(String id, String reason) async {
    emit(LoadingGetOrdersState());

    try {
      await firestore.collection("orders").doc(id).update({
        "statusDesc": reason,
        "status": "cancelled",
      });

      emit(SuccessGetOrdersState());
    } catch (e) {
      emit(ErrorGetOrdersState());
    }
  }

  void accpetOrder(String id, DateTime time) async {
    emit(LoadingGetOrdersState());

    try {
      await firestore.collection("orders").doc(id).update({
        "statusDesc": time.toString(),
        "status": "on way",
      });

      emit(SuccessGetOrdersState());
    } catch (e) {
      emit(ErrorGetOrdersState());
    }
  }

  void deliveredOrder(String id) async {
    emit(LoadingGetOrdersState());

    try {
      await firestore.collection("orders").doc(id).update({
        "status": "delivered",
      });

      emit(SuccessGetOrdersState());
    } catch (e) {
      emit(ErrorGetOrdersState());
    }
  }

  void recievedOrder(String id) async {
    emit(LoadingGetOrdersState());

    try {
      await firestore.collection("orders").doc(id).update({
        "status": "received",
      });

      emit(SuccessGetOrdersState());
    } catch (e) {
      emit(ErrorGetOrdersState());
    }
  }
}
