import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'sliders_state.dart';

class SlidersCubit extends Cubit<SlidersState> {
  SlidersCubit() : super(SlidersInitial());

  static SlidersCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> sliders = [];
  void getSliders() async {
    emit(LoadingSlidersState());
    try {
      firestore.collection("slider").snapshots().listen((data) {
        sliders = data.docs.map((e) {
          var d = e.data();
          d["id"] = e.id;
          return d;
        }).toList();
        emit(SuccessSlidersState());
      });
    } catch (e) {
      emit(ErrorSlidersState());
    }
  }

  void delete(Map<String, dynamic> item) async {
    emit(LoadingSlidersState());
    try {
      await firestore.collection("slider").doc(item["id"]).delete();
      emit(SuccessSlidersState());
    } catch (e) {
      emit(ErrorSlidersState());
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  void add() async {
    emit(LoadingSlidersState());
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);

        final storageRef = storage.ref();
        final imagesRef = storageRef.child("images/${image.name}");
        await imagesRef.putFile(file);
        String downloadURL = await imagesRef.getDownloadURL();

        await firestore.collection("slider").add({"value": downloadURL});

        emit(SuccessSlidersState());
      } else {
        emit(ErrorSlidersState());
      }
    } catch (e) {
      emit(ErrorSlidersState());
    }
  }
}
