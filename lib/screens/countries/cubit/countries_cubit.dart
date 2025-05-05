import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/screens/countries/models/country_model.dart';
import 'package:meta/meta.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitial());

  static CountriesCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  List<CountryModel> countries = [];

  void getCountries() async {
    emit(LoadingCountriesState());

    try {
      var data = await firestore.collection("countries").get();

      countries = data.docs.map((e) => CountryModel.fromFirebase(e)).toList();
      emit(SuccessCountriesState());
    } catch (e) {
      emit(ErrorCountriesState());
    }
  }

  void createCountry(String name, String address) async {
    emit(LoadingCountriesState());
    try {
      var data =
          await firestore.collection("countries").doc(name.toLowerCase()).get();
      if (data.exists) {
        emit(ErrorCountriesState());
        return;
      }
      await firestore.collection("countries").doc(name.toLowerCase()).set({
        "name": name,
        "address": address,
      });
      emit(SuccessCountriesState());
    } catch (e) {
      emit(ErrorCountriesState());
    }
  }
}
