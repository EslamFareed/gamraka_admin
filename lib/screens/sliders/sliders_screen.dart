import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_colors.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/sliders/add_slider_screen.dart';
import 'package:gamraka_admin/screens/sliders/cubit/sliders_cubit.dart';

class SlidersScreen extends StatelessWidget {
  const SlidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SlidersCubit.get(context).getSliders();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sliders ADS"),
        actions: [
          IconButton(
            onPressed: () {
              context.goToPage(AddSliderScreen());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<SlidersCubit, SlidersState>(
        builder: (context, state) {
          if (state is LoadingSlidersState) {
            return Center(child: CircularProgressIndicator());
          }
          var list = SlidersCubit.get(context).sliders;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Are you sure you want to delete this image ?",
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              SlidersCubit.get(context).delete(list[index]);
                              Navigator.pop(context);
                            },
                            color: AppColors.primary,
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  child: Image.network(
                    list[index]["value"],
                    height: 150,
                    width: context.screenWidth * .5,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
