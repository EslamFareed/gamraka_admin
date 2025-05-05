import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/routes/cubit/routes_cubit.dart';
// import 'package:gamraka_admin/screens/countries/cubit/countries_cubit.dart';

import 'create_route_screen.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RoutesCubit.get(context).getRoutes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Routes"),
        actions: [
          IconButton(
            onPressed: () {
              context.goToPage(CreateRouteScreen());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<RoutesCubit, RoutesState>(
        builder: (context, state) {
          return state is LoadingRoutesState
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemBuilder: (context, index) {
                  final item = RoutesCubit.get(context).routes[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        "From : ${item.from ?? ""}\nTo : ${item.to ?? ""}",
                      ),
                      subtitle: Text("Cost : ${item.cost}"),
                    ),
                  );
                },
                itemCount: RoutesCubit.get(context).routes.length,
              );
        },
      ),
    );
  }
}
