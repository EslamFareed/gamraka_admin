import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/categories/cubit/categories_cubit.dart';

import 'create_category_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoriesCubit.get(context).getCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              context.goToPage(CreateCategoryScreen());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return state is LoadingCategoriesState
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemBuilder: (context, index) {
                  final item = CategoriesCubit.get(context).categories[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(item.icon ?? ""),
                      title: Text(item.name ?? ""),
                      subtitle: Text("${item.fees}"),
                    ),
                  );
                },
                itemCount: CategoriesCubit.get(context).categories.length,
              );
        },
      ),
    );
  }
}
