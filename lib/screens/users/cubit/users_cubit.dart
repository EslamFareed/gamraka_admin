import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  static UsersCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<UserModel> users = [];

  void getUsers() async {
    emit(LoadingUsersState());
    try {
      var data = await firestore.collection("users").get();
      users = data.docs.map((e) => UserModel.fromJson(e.data(), e.id)).toList();
      emit(SuccessUsersState());
    } catch (e) {
      emit(ErrorUsersState());
    }
  }
}
