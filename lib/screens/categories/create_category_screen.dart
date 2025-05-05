import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_colors.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/categories/cubit/categories_cubit.dart';
import 'package:gamraka_admin/screens/dashboard/dashboard_screen.dart';

class CreateCategoryScreen extends StatelessWidget {
  CreateCategoryScreen({super.key});

  final nameController = TextEditingController();
  final feesController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Category")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                //! ------------------- Category Name ------------------!
                Row(children: [Text("Category Name")]),
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
                      return "Category Name is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),
                //! ------------------- fees ------------------!
                Row(children: [Text("fees")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: feesController,
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
                      return "fees is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                SizedBox(height: 50),
                BlocConsumer<CategoriesCubit, CategoriesState>(
                  listener: (context, state) {
                    if (state is ErrorCategoriesState) {
                      context.showErrorSnack(
                        "Error, or this Cateogry already exist",
                      );
                    } else if (state is SuccessCategoriesState) {
                      context.showSuccessSnack("Created Successfully");
                      context.goOffAll(DashboardScreen());
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingCategoriesState
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
                                CategoriesCubit.get(context).createCategory(
                                  nameController.text,
                                  num.parse(feesController.text),
                                );
                              }
                            },
                            child: Text(
                              "Create New Category",
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
