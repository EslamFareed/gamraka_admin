import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/screens/asks/models/ask_model.dart';
import 'package:meta/meta.dart';

part 'asks_state.dart';

class AsksCubit extends Cubit<AsksState> {
  AsksCubit() : super(AsksInitial());

  static AsksCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<AskModel> asks = [];

  void getAsks() async {
    emit(LoadingAsksState());
    try {
      firestore.collection("asks").snapshots().listen((data) {
        asks = data.docs.map((e) => AskModel.fromJson(e.data(), e.id)).toList();
        emit(SuccessAsksState());
      });
    } catch (e) {
      emit(ErrorAsksState());
    }
  }

  void replyAsk(String id, String answer) async {
    emit(LoadingReplyAsksState());
    try {
      await firestore.collection("asks").doc(id).update({"answer": answer});
      emit(SuccessReplyAsksState());
    } catch (e) {
      emit(ErrorReplyAsksState());
    }
  }
}
