import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_colors.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/countries/cubit/countries_cubit.dart';
// import 'package:gamraka_admin/screens/admins/cubit/admins_cubit.dart';
import 'package:gamraka_admin/screens/dashboard/dashboard_screen.dart';

class CreateCountryScreen extends StatelessWidget {
  CreateCountryScreen({super.key});

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Country")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                //! ------------------- Country Name ------------------!
                Row(children: [Text("Country Name")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Country Name is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),
                //! ------------------- Address ------------------!
                Row(children: [Text("Address")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Address is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                SizedBox(height: 50),
                BlocConsumer<CountriesCubit, CountriesState>(
                  listener: (context, state) {
                    if (state is ErrorCountriesState) {
                      context.showErrorSnack(
                        "Error, or this country already exist",
                      );
                    } else if (state is SuccessCountriesState) {
                      context.showSuccessSnack("Created Successfully");
                      context.goOffAll(DashboardScreen());
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingCountriesState
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (globalKey.currentState?.validate() ?? false) {
                                CountriesCubit.get(context).createCountry(
                                  nameController.text,
                                  addressController.text,
                                );
                              }
                            },
                            child: Text(
                              "Create New Country",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
