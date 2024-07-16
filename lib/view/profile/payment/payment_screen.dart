import 'package:dineease/model/restro/payment.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view/profile/payment/bill_screen.dart';
import 'package:dineease/view/widgets/no_data_widget.dart';
import 'package:dineease/view_model/restro/payment_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaymentViewModel>(context, listen: false).fetchPayments();
    });
  }

  String selectedDepartment = 'cash';
  String selectedPeriod = 'Today';

  @override
  Widget build(BuildContext context) {
    final paymentVM = Provider.of<PaymentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Payments",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalpadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPeriod = 'today';
                        paymentVM.filterPayments(
                            selectedDepartment, selectedPeriod);
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 75,
                      decoration: BoxDecoration(
                        color: selectedPeriod == 'today'
                            ? Colors.orange.withOpacity(0.8)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: Text(
                          "today",
                          style: MyTextStyle.subtitle
                              .copyWith(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPeriod = '7 days';
                        paymentVM.filterPayments(
                            selectedDepartment, selectedPeriod);
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 75,
                      decoration: BoxDecoration(
                        color: selectedPeriod == '7 days'
                            ? Colors.orange.withOpacity(0.8)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: Text(
                          "7 days",
                          style: MyTextStyle.subtitle
                              .copyWith(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPeriod = 'Monthly';
                        paymentVM.filterPayments(
                            selectedDepartment, selectedPeriod);
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 75,
                      decoration: BoxDecoration(
                        color: selectedPeriod == 'Monthly'
                            ? Colors.orange.withOpacity(0.8)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: Text(
                          "Monthly",
                          style: MyTextStyle.subtitle
                              .copyWith(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPeriod = 'yearly';
                        paymentVM.filterPayments(
                            selectedDepartment, selectedPeriod);
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 75,
                      decoration: BoxDecoration(
                        color: selectedPeriod == 'yearly'
                            ? Colors.orange.withOpacity(0.8)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: Text(
                          "yearly",
                          style: MyTextStyle.subtitle
                              .copyWith(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.verticalpadding * 3),
            DropdownButtonHideUnderline(
              child: Container(
                height: 40,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: DropdownButton<String>(
                  value: selectedDepartment,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDepartment = newValue!;
                      paymentVM.filterPayments(
                          selectedDepartment, selectedPeriod);
                    });
                  },
                  dropdownColor: Colors.white,
                  items: <String>[
                    'cash',
                    'card',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: MyTextStyle.subtitle.copyWith(fontSize: 13),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.verticalpadding * 2),
            paymentVM.payments.isEmpty
                ? const NoData(
                    title: 'No Payments',
                    subtitle: 'No payment has done yet',
                    icon: Icons.payment_outlined,
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: paymentVM.payments.length,
                      itemBuilder: (context, index) {
                        final payment = paymentVM.payments[index];
                        return PaymentCard(payment: payment);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final Payment payment;

  const PaymentCard({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Bill(payment: payment),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('#Order ID: ${payment.order}',
                      style: MyTextStyle.title.copyWith(fontSize: 15)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("COMPLETE",
                        style: MyTextStyle.body
                            .copyWith(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Tax: ${payment.tax}',
                style: MyTextStyle.body.copyWith(fontSize: 15),
              ),
              Text(
                'Discount: ${payment.discount}',
                style: MyTextStyle.body.copyWith(fontSize: 15),
              ),
              Text(
                'Amount: ${payment.amount?.toStringAsFixed(2)}',
                style: MyTextStyle.body.copyWith(fontSize: 15),
              ),
              
              if (payment.cashier != null)
                Text(
                  'Cashier: ${payment.cashier}',
                  style: MyTextStyle.body.copyWith(fontSize: 15),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
