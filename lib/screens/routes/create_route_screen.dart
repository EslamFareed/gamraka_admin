import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_colors.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/dashboard/dashboard_screen.dart';
import 'package:gamraka_admin/screens/routes/cubit/routes_cubit.dart';

import '../countries/models/country_model.dart';

class CreateRouteScreen extends StatelessWidget {
  CreateRouteScreen({super.key});

  final costController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Route")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                //! ------------------- From Country ------------------!
                Row(children: [Text("From Country")]),
                SizedBox(height: 5),
                BlocBuilder<RoutesCubit, RoutesState>(
                  builder: (context, state) {
                    return DropdownButtonFormField<CountryModel>(
                      onChanged: (value) {
                        RoutesCubit.get(context).selectFrom(value);
                      },
                      items:
                          RoutesCubit.get(context).countries.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e.name ?? ""),
                            );
                          }).toList(),
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
                        if (value == null) {
                          return "From Country is required";
                        }

                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- To Country ------------------!
                Row(children: [Text("To Country")]),
                SizedBox(height: 5),
                BlocBuilder<RoutesCubit, RoutesState>(
                  builder: (context, state) {
                    return DropdownButtonFormField<CountryModel>(
                      onChanged: (value) {
                        RoutesCubit.get(context).selectTo(value);
                      },
                      items: [
                        DropdownMenuItem(
                          value: RoutesCubit.get(context).egypt,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/egypt_flag.png",
                                width: 75,
                                height: 40,
                              ),
                              Text("${RoutesCubit.get(context).egypt!.name}"),
                            ],
                          ),
                        ),
                      ],
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
                        if (value == null) {
                          return "To Country is required";
                        }
                        if (value == RoutesCubit.get(context).from) {
                          return "From and To Country can't be same";
                        }

                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- Cost ------------------!
                Row(children: [Text("Cost")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: costController,
                  keyboardType: TextInputType.number,
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
                      return "Cost is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                SizedBox(height: 50),
                BlocConsumer<RoutesCubit, RoutesState>(
                  listener: (context, state) {
                    if (state is ErrorRoutesState) {
                      context.showErrorSnack(
                        "Error, or this Route already exist",
                      );
                    } else if (state is SuccessRoutesState) {
                      context.showSuccessSnack("Created Successfully");
                      context.goOffAll(DashboardScreen());
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingRoutesState
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
                                RoutesCubit.get(
                                  context,
                                ).createRoute(num.parse(costController.text));
                              }
                            },
                            child: Text(
                              "Create New Route",
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
