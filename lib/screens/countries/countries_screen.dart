import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/countries/cubit/countries_cubit.dart';

import 'create_country_screen.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CountriesCubit.get(context).getCountries();
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
        actions: [
          IconButton(
            onPressed: () {
              context.goToPage(CreateCountryScreen());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) {
          return state is LoadingCountriesState
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemBuilder: (context, index) {
                  final item = CountriesCubit.get(context).countries[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.name ?? ""),
                      subtitle: Text(item.address ?? ""),
                    ),
                  );
                },
                itemCount: CountriesCubit.get(context).countries.length,
              );
        },
      ),
    );
  }
}
