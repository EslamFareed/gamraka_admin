import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_colors.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';

import 'cubit/sliders_cubit.dart';

class AddSliderScreen extends StatelessWidget {
  AddSliderScreen({super.key});

  final linkController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Slider")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Link must be not empty";
                    }
                    return null;
                  },
                  controller: linkController,
                  decoration: InputDecoration(
                    labelText: "Link",
                    prefixIcon: Icon(Icons.link),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                BlocConsumer<SlidersCubit, SlidersState>(
                  listener: (_, state) {
                    if (state is ErrorSlidersState) {
                      context.showErrorSnack("Error, Please Try again");
                    } else if (state is SuccessSlidersState) {
                      context.showSuccessSnack("Created Successfully");
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingSlidersState
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
                                SlidersCubit.get(
                                  context,
                                ).add(linkController.text);
                              }
                            },
                            child: Text(
                              "Add Slider",
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
