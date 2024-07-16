import 'package:dineease/model/restro/payment.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:dineease/view_model/restro/order_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bill extends StatelessWidget {
  final Payment payment;
  const Bill({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Invoice",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalpadding * 1.5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppConstants.verticalpadding * 2.5),
              Text(
                "DINE EASE",
                style: MyTextStyle.title.copyWith(
                  fontSize: 15,
                ),
              ),
              Text(
                "Bindabasini -2, Pokhara",
                style: MyTextStyle.subtitle
                    .copyWith(fontSize: 14, color: AppColors.BillyColor),
              ),
              Text(
                "Order INVOICE",
                style: MyTextStyle.subtitle
                    .copyWith(fontSize: 14, color: AppColors.BillyColor),
              ),
              const SizedBox(height: AppConstants.verticalpadding * 2.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BillCard(
                    payment: payment,
                  ),

                  const SizedBox(height: AppConstants.verticalpadding * 9),
                  // short description
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.horizontalpadding * 3),
                    child: Text(
                      maxLines: 3,
                      "This bill an internal working copy.for official purpose,kindly accept the original bill from the counter,as this bill is for estimate purpose only ",
                      textAlign: TextAlign.center,
                      style: MyTextStyle.subtitle.copyWith(
                          fontSize: 11,
                          letterSpacing: 1,
                          color: AppColors.BillyColor),
                    ),
                  ),
                  const SizedBox(height: AppConstants.verticalpadding),
                  Center(
                    child: Text(
                      "Thank You !!!",
                      style: MyTextStyle.subtitle
                          .copyWith(fontSize: 14, color: AppColors.BillyColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BillCard extends StatelessWidget {
  final Payment payment;
  const BillCard({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final orderVM = Provider.of<OrderViewModel>(context);
    final order = orderVM.orders.firstWhere(
      (element) => element.id == payment.order,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ORDER ID : ${order.id}",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
            Text(
              "Date : ${payment.createdAt.toString().substring(0, 10)}",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Paid Status : Paid",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '${payment.paymentMethod}',
                style: MyTextStyle.subtitle
                    .copyWith(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.verticalpadding * 1.5),
        Text(
          "Checked By : ${payment.cashier}",
          style: MyTextStyle.subtitle
              .copyWith(fontSize: 14, color: AppColors.BillyColor),
        ),
        const SizedBox(height: AppConstants.verticalpadding * 1.5),

        const Divider(
          endIndent: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "Particular",
                style: MyTextStyle.subtitle
                    .copyWith(fontSize: 14, color: AppColors.BillyColor),
              ),
            ),
            Expanded(
              child: Text(
                "Rate",
                style: MyTextStyle.subtitle
                    .copyWith(fontSize: 14, color: AppColors.BillyColor),
              ),
            ),
            Expanded(
              child: Text(
                "QTY",
                style: MyTextStyle.subtitle
                    .copyWith(fontSize: 14, color: AppColors.BillyColor),
              ),
            ),
            Expanded(
              child: Text(
                "Subtotal",
                style: MyTextStyle.subtitle
                    .copyWith(fontSize: 14, color: AppColors.BillyColor),
              ),
            ),
          ],
        ),
        const Divider(),
        // listview of bill
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: order.orderItems.length,
            itemBuilder: (context, index) {
              final orderItem = order.orderItems[index];
              final item = Provider.of<ItemViewModel>(context).items.firstWhere(
                    (element) => element.id == orderItem.item,
                  );

              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.verticalpadding),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        item.name,
                        style: MyTextStyle.thin.copyWith(fontSize: 11),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.price,
                        style: MyTextStyle.thin.copyWith(fontSize: 11),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        orderItem.quantity,
                        style: MyTextStyle.thin.copyWith(fontSize: 11),
                      ),
                    ),
                    Expanded(
                      child: Text(
                          (double.parse(item.price) *
                                  double.parse(orderItem.quantity))
                              .toString(),
                          style: MyTextStyle.thin.copyWith(fontSize: 11)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(),
        //subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sub Total",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
            Text(
              "Rs ${payment.amount} /-",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
            Text(
              "Rs ${payment.tax} /-",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Discount",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
            Text(
              "Rs ${payment.discount} /-",
              style: MyTextStyle.subtitle
                  .copyWith(fontSize: 14, color: AppColors.BillyColor),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.verticalpadding * 2),
        //Grand total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "GRAND TOTAL",
              style: MyTextStyle.subtitle.copyWith(fontSize: 15),
            ),
            Text(
              "Rs ${payment.total} /-",
              style: MyTextStyle.subtitle.copyWith(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}
