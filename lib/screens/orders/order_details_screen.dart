import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/screens/orders/cubit/orders_cubit.dart';
import 'package:gamraka_admin/screens/orders/models/order_model.dart';

import '../../core/utils/app_colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel item;

  const OrderDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order: ${item.id}'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is SuccessGetOrdersState) {
            OrdersCubit.get(context).getOrders();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _statusBanner(item.status, item.statusDesc),
              const SizedBox(height: 16),
              _sectionTitle('User Information'),
              _userCard(item.user),
              const SizedBox(height: 16),
              _sectionTitle('Item Details'),
              _itemInfo(item),

              const SizedBox(height: 16),
              _sectionTitle('Verification Image'),
              Image.network(item.verificationImage),
              const SizedBox(height: 16),
              _sectionTitle('Shipping Information'),
              _shippingRoute(item),
              const SizedBox(height: 16),
              _sectionTitle('Dates'),
              _infoTile('Created At', item.createdAt.toString()),
              _infoTile('Pickup Date', item.pickupDate.toString()),
              const SizedBox(height: 16),
              _sectionTitle('Pricing'),
              _priceBreakdown(item),

              if (item.status == "pending") acceptOrCancel(context, state),

              if (item.status == "on way")
                state is LoadingGetOrdersState
                    ? Center(child: CircularProgressIndicator())
                    : MaterialButton(
                      onPressed: () async {
                        OrdersCubit.get(context).deliveredOrder(item.id);
                      },
                      minWidth: context.screenWidth,
                      height: 50,
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Delivered To Destination",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

              if (item.status == "delivered")
                state is LoadingGetOrdersState
                    ? Center(child: CircularProgressIndicator())
                    : MaterialButton(
                      onPressed: () async {
                        OrdersCubit.get(context).recievedOrder(item.id);
                      },
                      minWidth: context.screenWidth,
                      height: 50,
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "User Recieved Order",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget acceptOrCancel(BuildContext context, OrdersState state) {
    return state is LoadingGetOrdersState
        ? Center(child: CircularProgressIndicator())
        : Row(
          spacing: 10,
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  var date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(hours: 1000)),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    var time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      OrdersCubit.get(context).accpetOrder(
                        item.id,
                        date.copyWith(hour: time.hour, minute: time.minute),
                      );
                    } else {
                      context.showErrorSnack("Choose Date First Then Time");
                    }
                  } else {
                    context.showErrorSnack("Choose Date First Then Time");
                  }
                },
                minWidth: context.screenWidth,
                height: 50,
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text("Accpet", style: TextStyle(color: Colors.white)),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  final reasonController = TextEditingController();
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              spacing: 15,
                              children: [
                                TextField(
                                  controller: reasonController,
                                  decoration: InputDecoration(
                                    labelText: "Enter Cancellation Reason",
                                  ),
                                ),

                                MaterialButton(
                                  onPressed: () {
                                    if (reasonController.text.isEmpty) {
                                      context.showErrorSnack(
                                        "Please enter reason",
                                      );
                                      return;
                                    }
                                    OrdersCubit.get(context).cancelOrder(
                                      item.id,
                                      reasonController.text,
                                    );
                                    Navigator.pop(context);
                                  },
                                  minWidth: context.screenWidth,
                                  height: 50,
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                minWidth: context.screenWidth,
                height: 50,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text("Cancel", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
  }

  Widget _statusBanner(String status, String desc) {
    return Card(
      color: Colors.grey.shade200,
      child: ListTile(
        leading: Icon(Icons.local_shipping, color: AppColors.primary),
        title: Text('Status: ${status.toUpperCase()}'),
        subtitle: Text("Desc : $desc"),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _userCard(User user) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
        title: Text(user.name),
        subtitle: Text('Phone: ${user.phone}\nID: ${user.idNumber}'),
      ),
    );
  }

  Widget _itemInfo(OrderModel item) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Image.network(item.category.icon, width: 40),
            title: Text(item.itemName),
            subtitle: Text(item.itemDesc),
            trailing: Text(item.category.name),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight: ${item.weight} kg'),
                Text('Price: \$${item.itemPrice.toStringAsFixed(2)}'),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _shippingRoute(OrderModel item) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.green),
        title: Text('From: ${item.from}'),
        subtitle: Text('To: ${item.to}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.compare_arrows),
            Text(item.methodType.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.calendar_today),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _priceBreakdown(OrderModel item) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: const Text('Shipping'),
            trailing: Text('\$${item.shippingCost.toStringAsFixed(2)}'),
          ),
          ListTile(
            title: const Text('Taxes'),
            trailing: Text('\$${item.taxes.toStringAsFixed(2)}'),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Total',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '\$${item.total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
