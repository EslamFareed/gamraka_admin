import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/users_cubit.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersCubit.get(context).getUsers();
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return Center(child: CircularProgressIndicator());
          }
          final list = UsersCubit.get(context).users;
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                child: ListTile(
                  leading: Image.network(item.image),
                  title: Text(
                    "name : ${item.name}\nphone : ${item.phone}\nid number : ${item.idNumber}",
                  ),
                ),
              );
            },
            itemCount: list.length,
          );
        },
      ),
    );
  }
}
