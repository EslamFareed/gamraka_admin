import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/screens/categories/models/category_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  List<CategoryModel> categories = [];

  void getCategories() async {
    emit(LoadingCategoriesState());

    try {
      var data = await firestore.collection("categories").get();

      categories = data.docs.map((e) => CategoryModel.fromFirebase(e)).toList();
      emit(SuccessCategoriesState());
    } catch (e) {
      emit(ErrorCategoriesState());
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  void createCategory(String name, num fees) async {
    emit(LoadingCategoriesState());
    try {
      var data =
          await firestore
              .collection("categories")
              .doc(name.toLowerCase())
              .get();
      if (data.exists) {
        emit(ErrorCategoriesState());
        return;
      }
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);

        final storageRef = storage.ref();
        final imagesRef = storageRef.child("images/${image.name}");
        await imagesRef.putFile(file);
        String downloadURL = await imagesRef.getDownloadURL();

        await firestore.collection("categories").doc(name.toLowerCase()).set({
          "name": name,
          "icon": downloadURL,
          "fees": fees,
        });
        emit(SuccessCategoriesState());
      } else {
        emit(ErrorCategoriesState());
      }
    } catch (e) {
      emit(ErrorCategoriesState());
    }
  }
}
