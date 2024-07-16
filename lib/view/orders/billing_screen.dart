import 'package:dineease/model/restro/order.dart';
import 'package:dineease/model/restro/payment.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view/orders/transaction_screen.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:dineease/view_model/restro/order_vm.dart';
import 'package:dineease/view_model/restro/payment_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillingScreen extends StatefulWidget {
  final Order order;
  const BillingScreen({
    super.key,
    required this.order,
  });

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  double subtotal = 0;
  double total = 0;

  final discountController = TextEditingController();
  final taxController = TextEditingController();

  String paymentMethod = 'cash';

  @override
  void initState() {
    super.initState();
    calculateSubtotal();
  }

  void calculateSubtotal() {
    final itemVM = Provider.of<ItemViewModel>(context, listen: false);
    double calculatedSubtotal = 0;
    for (var orderItem in widget.order.orderItems) {
      final item =
          itemVM.items.firstWhere((element) => element.id == orderItem.item);
      calculatedSubtotal +=
          double.parse(item.price) * double.parse(orderItem.quantity);
    }
    setState(() {
      subtotal = calculatedSubtotal;
      total = subtotal;
    });
  }

  double calculateFinalTotal(double subtotal, double discount, double tax) {
    double discountedTotal = subtotal - discount;
    double finalTotal = discountedTotal + tax;
    return finalTotal;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Billing Process",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.widthPadding * 1.3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppConstants.verticalpadding * 1.5),
              const Divider(),
              // Order list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Particular",
                      style: MyTextStyle.subtitle
                          .copyWith(fontSize: 14, color: AppColors.BillyColor),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Qty",
                      style: MyTextStyle.subtitle
                          .copyWith(fontSize: 14, color: AppColors.BillyColor),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Rate",
                      style: MyTextStyle.subtitle
                          .copyWith(fontSize: 14, color: AppColors.BillyColor),
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
                    final item =
                        Provider.of<ItemViewModel>(context).items.firstWhere(
                              (element) => element.id == orderItem.item,
                            );

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Pay",
                    style: MyTextStyle.title.copyWith(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Text(
                    "Rs. $total",
                    style: MyTextStyle.title.copyWith(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: AppConstants.verticalpadding * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.053,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "Discount",
                        style: MyTextStyle.body.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: screenWidth * 0.3,
                    child: TextFormField(
                      controller: discountController,
                      style: MyTextStyle.subtitle,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.horizontalpadding * 2),
                        hintText: 'RS',
                        hintStyle: MyTextStyle.subtitle,
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.verticalpadding * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.053,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "TAX",
                        style: MyTextStyle.body.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: screenWidth * 0.3,
                    child: TextFormField(
                      controller: taxController,
                      style: MyTextStyle.subtitle,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.horizontalpadding * 2),
                        hintText: 'RS',
                        hintStyle: MyTextStyle.subtitle,
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.verticalpadding * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.053,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "Payment",
                        style: MyTextStyle.body.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.053,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: paymentMethod,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        iconSize: 24,
                        elevation: 16,
                        style: MyTextStyle.body.copyWith(color: Colors.black),
                        onChanged: (newValue) {
                          setState(() {
                            paymentMethod = newValue!;
                          });
                        },
                        items: <String>['cash', 'card']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.verticalpadding * 7),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.056,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    if (discountController.text.isNotEmpty &&
                        taxController.text.isNotEmpty) {
                      final paymentVM =
                          Provider.of<PaymentViewModel>(context, listen: false);
                      final orderVM =
                          Provider.of<OrderViewModel>(context, listen: false);

                      double discount = double.parse(discountController.text);
                      double tax = double.parse(taxController.text);
                      double finalTotal =
                          calculateFinalTotal(subtotal, discount, tax);

                      final payment = Payment(
                        order: widget.order.id!,
                        tax: tax,
                        discount: discount,
                        amount: finalTotal,
                        paymentMethod: paymentMethod,
                        paymentStatus: 'completed',
                      );
                      
                      paymentVM.addPayment(payment);

                      orderVM.updateOrderStatus(
                          widget.order.id.toString(), 'completed');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TransactionScreen(
                            totalAmount: finalTotal,
                            paymentMethod: paymentMethod,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Proceed',
                    style: MyTextStyle.body.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
