import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/screens/countries/models/country_model.dart';
import 'package:gamraka_admin/screens/routes/models/route_model.dart';
import 'package:meta/meta.dart';

part 'routes_state.dart';

class RoutesCubit extends Cubit<RoutesState> {
  RoutesCubit() : super(RoutesInitial());

  static RoutesCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  List<RouteModel> routes = [];

  void getRoutes() async {
    emit(LoadingRoutesState());

    try {
      var data = await firestore.collection("routes").get();

      routes = data.docs.map((e) => RouteModel.fromFirebase(e)).toList();

      var dataCountries = await firestore.collection("countries").get();

      countries =
          dataCountries.docs.map((e) => CountryModel.fromFirebase(e)).toList();
      emit(SuccessRoutesState());
    } catch (e) {
      emit(ErrorRoutesState());
    }
  }

  List<CountryModel> countries = [];

  CountryModel? from;
  CountryModel? to;

  void selectFrom(CountryModel? country) {
    emit(StartChooseCountryState());
    from = country;
    emit(EndChooseCountryState());
  }

  
  void selectTo(CountryModel? country) {
    emit(StartChooseCountryState());
    to = country;
    emit(EndChooseCountryState());
  }

  void createRoute(num cost) async {
    emit(LoadingRoutesState());
    try {
      var data =
          await firestore
              .collection("routes")
              .doc("${from!.name!.toLowerCase()}_${to!.name!.toLowerCase()}")
              .get();
      if (data.exists) {
        emit(ErrorRoutesState());
        return;
      }
      await firestore
          .collection("routes")
          .doc("${from!.name!.toLowerCase()}_${to!.name!.toLowerCase()}")
          .set({"from": from!.name, "to": to!.name, "cost": cost});
      emit(SuccessRoutesState());
    } catch (e) {
      emit(ErrorRoutesState());
    }
  }
}
