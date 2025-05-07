import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/orders/cubit/orders_cubit.dart';
import 'package:gamraka_admin/screens/orders/order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersCubit.get(context).getOrders();
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is LoadingGetOrdersState) {
            return Center(child: CircularProgressIndicator());
          }
          final list = OrdersCubit.get(context).orders;
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                color: Colors.grey.shade200,
                child: ListTile(
                  onTap: () {
                    context.goToPage(OrderDetailsScreen(item: item));
                  },
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.status.toUpperCase()),
                      Divider(),

                      Text(
                        "Order Data",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      Text("id : ${item.id}"),
                      Text("from : ${item.from}"),
                      Text("to : ${item.to}"),
                      Text("item : ${item.itemName}"),
                      Text("Total : ${item.total}"),

                      Divider(),
                      Text(
                        "User Data",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      Text("Name : ${item.user.name}"),
                      Text("phone : ${item.user.phone}"),
                      Text("id : ${item.user.idNumber}"),
                    ],
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
