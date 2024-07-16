import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/model/restro/order.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view/orders/order_detail_screen.dart';
import 'package:dineease/view/orders/take_orders_screen.dart';
import 'package:dineease/view/widgets/no_data_widget.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:dineease/view_model/restro/order_vm.dart';
import 'package:dineease/view_model/restro/table_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TableViewModel>(context, listen: false).fetchTables();
      Provider.of<OrderViewModel>(context, listen: false).fetchOrders();
      Provider.of<ProfileViewModel>(context, listen: false).fetchProfile();
    });
  }

  Future<void> _showTableSelectionDialog(BuildContext context) async {
    final tableVM = Provider.of<TableViewModel>(context, listen: false);
    final tables = tableVM.tables;

    if (tables.isEmpty) {
      MySnackBar.showSnackBar(context, 'No available tables');
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                children: [
                  ...tables.map(
                    (table) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (table.isOccupied) {
                            MySnackBar.showSnackBar(
                              context,
                              'Table is already occupied',
                            );
                            return;
                          } else {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TakeOrderScreen(
                                  tableId: table.id.toString(),
                                  tableNumber: table.number.toString(),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: table.isOccupied
                                ? Colors.grey.withOpacity(0.3)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                table.number,
                                style: MyTextStyle.title.copyWith(fontSize: 15),
                              ),
                              Text(
                                'Seats: ${table.seats}',
                                style: MyTextStyle.body.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderVM = Provider.of<OrderViewModel>(context);
    final tableVM = Provider.of<TableViewModel>(context);

    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final Profile user = profileVM.user;

    final tableNo = tableVM.tables.map((e) => e.number).first;

    List<Order> orders = [];
    orders = orderVM.orders;
    final servedOrders =
        orderVM.orders.where((element) => element.status == 'served').toList();

    final placedOrders =
        orderVM.orders.where((element) => element.status == 'placed').toList();

    final waiterOrders = orderVM.orders
        .where((element) =>
            (element.status == 'ready' || element.status == 'placed'))
        .toList();

    if (user.role == 'waiter') {
      orders = waiterOrders;
    } else if (user.role == 'cook') {
      orders = placedOrders;
    } else if (user.role == 'cashier') {
      orders = servedOrders;
    } else {
      orders = orderVM.orders;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
        child: orders.isEmpty
            ? const NoData(
                title: 'No Orders',
                subtitle: 'Take orders to have order',
                icon: Icons.fastfood_sharp,
              )
            : SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await orderVM.fetchOrders();
                  },
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: orders.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderDetailScreen(
                                      order: order,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('#ORDER ID: ${order.id}',
                                        style: MyTextStyle.title
                                            .copyWith(fontSize: 15)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(order.status),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          getStatus(order.status),
                                          style: MyTextStyle.subtitle.copyWith(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Ordered by: ',
                                          style: MyTextStyle.body
                                              .copyWith(fontSize: 14),
                                        ),
                                        if (tableVM.tables.isNotEmpty)
                                          Text(
                                            order.orderedBy!,
                                            style: MyTextStyle.body.copyWith(
                                              fontSize: 14,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          order.orderTime
                                              .toString()
                                              .substring(0, 10),
                                          style: MyTextStyle.body
                                              .copyWith(fontSize: 14),
                                        ),
                                        if (tableVM.tables.isNotEmpty)
                                          Text(
                                            'Table No.: $tableNo ',
                                            style: MyTextStyle.thin
                                                .copyWith(fontSize: 13),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
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
      floatingActionButton: user.role == 'waiter'
          ? FloatingActionButton.extended(
              onPressed: () async {
                _showTableSelectionDialog(context);
              },
              icon: const Icon(Icons.fastfood_sharp),
              label: const Text(
                'Take Order',
                style: MyTextStyle.body,
              ),
            )
          : null,
    );
  }

  String getStatus(String name) {
    String result = '';
    switch (name) {
      case 'placed':
        result = 'Placed';
      case 'ready':
        result = 'Ready To Serve';
      case 'served':
        result = 'Served';
      case 'completed':
        result = 'Completed';
    }
    return result;
  }

  Color getStatusColor(String name) {
    Color result = Colors.grey;
    switch (name) {
      case 'placed':
        result = Colors.orange;
      case 'ready':
        result = Colors.green;
      case 'served':
        result = Colors.blue;
      case 'completed':
        result = Colors.green;
    }
    return result;
  }
}
