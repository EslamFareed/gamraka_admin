import 'package:flutter/material.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/core/utils/shared_helper.dart';

import 'package:gamraka_admin/screens/asks/asks_screen.dart';
import 'package:gamraka_admin/screens/categories/categories_screen.dart';
import 'package:gamraka_admin/screens/countries/countries_screen.dart';
import 'package:gamraka_admin/screens/routes/routes_screen.dart';
import 'package:gamraka_admin/screens/sliders/sliders_screen.dart';
import 'package:gamraka_admin/screens/users/users_screen.dart';

import '../admins/admins_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${SharedHelper.getAdminEmail()}")),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(AdminsScreen());
              },
              title: Text("Admins"),
              leading: Icon(Icons.dashboard),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(UsersScreen());
              },
              title: Text("Users"),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(AsksScreen());
              },
              title: Text("ASKS"),
              leading: Icon(Icons.question_mark),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(SlidersScreen());
              },
              title: Text("Sliders"),
              leading: Icon(Icons.image),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(CountriesScreen());
              },
              title: Text("Countries"),
              leading: Icon(Icons.location_city),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(RoutesScreen());
              },
              title: Text("Routes"),
              leading: Icon(Icons.route),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(CategoriesScreen());
              },
              title: Text("Categories"),
              leading: Icon(Icons.category),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ),
        ],
      ),
    );
  }
}
