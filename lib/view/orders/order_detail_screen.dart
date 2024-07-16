import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/model/restro/order.dart';
import 'package:dineease/style/components/dialogs.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view/orders/billing_screen.dart';
import 'package:dineease/view/profile/payment/bill_screen.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:dineease/view_model/restro/order_vm.dart';
import 'package:dineease/view_model/restro/payment_vm.dart';
import 'package:dineease/view_model/restro/table_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PaymentViewModel>(context, listen: false).fetchPayments();
    });
  }

  double total = 0;

  @override
  Widget build(BuildContext context) {
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final Profile user = profileVM.user;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final paymentVM = Provider.of<PaymentViewModel>(context, listen: false);
    bool isPaymentDone = paymentVM.isPaymentDone(widget.order.id!);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.widthPadding * 1.3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('#ORDER ID: ${widget.order.id}',
                          style: MyTextStyle.title.copyWith(fontSize: 15)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: getStatusColor(widget.order.status),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            getStatus(widget.order.status),
                            style: MyTextStyle.subtitle
                                .copyWith(fontSize: 13, color: Colors.white),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.order.orderTime.toString().substring(0, 10),
                            style: MyTextStyle.body.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: AppConstants.spaceHeight,
              ),
              if (isPaymentDone)
                BillCard(
                  payment: paymentVM.payments.firstWhere(
                    (element) => element.order == widget.order.id,
                  ),
                ),
              if (!isPaymentDone)
                Column(
                  children: [
                    const Divider(),
                    //order list
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Particular",
                            style: MyTextStyle.subtitle.copyWith(
                                fontSize: 14, color: AppColors.BillyColor),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            "Qty",
                            style: MyTextStyle.subtitle.copyWith(
                                fontSize: 14, color: AppColors.BillyColor),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            "Rate",
                            style: MyTextStyle.subtitle.copyWith(
                                fontSize: 14, color: AppColors.BillyColor),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 5),

                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.order.orderItems.length,
                        itemBuilder: (context, index) {
                          final orderItem = widget.order.orderItems[index];
                          final item = Provider.of<ItemViewModel>(context)
                              .items
                              .firstWhere(
                                (element) => element.id == orderItem.item,
                              );

                          total += double.parse(item.price) *
                              double.parse(orderItem.quantity);

                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: MyTextStyle.subtitle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  orderItem.quantity.toString(),
                                  style: MyTextStyle.subtitle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  item.price,
                                  style: MyTextStyle.subtitle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    SizedBox(height: screenHeight * 0.035),
                  ],
                ),
              if (widget.order.status == 'placed' && user.role == 'waiter')
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.056,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      AppDialogs.showMyDialog(
                        'Are you sure you want to cancel this order?',
                        context,
                        () async {
                          final orderVM = Provider.of<OrderViewModel>(context,
                              listen: false);
                          final tableVM = Provider.of<TableViewModel>(context,
                              listen: false);
                          await orderVM.deleteOrder(widget.order.id.toString());

                          orderVM.deleteOrder(widget.order.id.toString());
                          tableVM.changeTableStatus(
                              widget.order.table.toString(), false);

                          MySnackBar.showSnackBar(
                              context, 'Order Cancelled Successfully');
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Text(
                      'Cancel Order',
                      style: MyTextStyle.body.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              if (widget.order.status == 'placed' && user.role == 'cook')
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.056,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      AppDialogs.showMyDialog(
                        'Are you sure this order is ready to be served?',
                        context,
                        () {
                          final orderVM = Provider.of<OrderViewModel>(context,
                              listen: false);

                          orderVM.updateOrderStatus(
                              widget.order.id.toString(), 'ready');

                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Text(
                      'Ready To Serve',
                      style: MyTextStyle.body.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              if (widget.order.status == 'ready' && user.role == 'waiter')
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.056,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      AppDialogs.showMyDialog(
                        'Are you sure this order is served?',
                        context,
                        () {
                          final orderVM = Provider.of<OrderViewModel>(context,
                              listen: false);
                          final tableVM = Provider.of<TableViewModel>(context,
                              listen: false);

                          orderVM.updateOrderStatus(
                              widget.order.id.toString(), 'served');
                          tableVM.changeTableStatus(
                              widget.order.table.toString(), false);

                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Text(
                      'Served',
                      style: MyTextStyle.body.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              if (widget.order.status == 'served')
                if (!isPaymentDone)
                  SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.056,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BillingScreen(
                              order: widget.order,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Proceed To Checkout',
                        style: MyTextStyle.body.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
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
