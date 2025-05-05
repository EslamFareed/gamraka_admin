import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? adminData;
  void loginAsAdmin(String email, String password) async {
    emit(LoadingLoginAdminState());
    try {
      var dataAuth = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (dataAuth.user != null) {
        var data =
            await firestore.collection("admins").doc(dataAuth.user?.uid).get();
        if (data.exists) {
          adminData = {"email": email, "id": dataAuth.user!.uid};

          emit(SuccessLoginAdminState());
        } else {
          emit(ErrorLoginAdminState());
        }
      } else {
        emit(ErrorLoginAdminState());
      }
    } catch (e) {
      emit(ErrorLoginAdminState());
    }
  }
}
