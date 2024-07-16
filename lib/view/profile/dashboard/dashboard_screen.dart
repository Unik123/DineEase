import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/restro/dashboard_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardViewModel>(context, listen: false)
          .fetchDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardVM = Provider.of<DashboardViewModel>(context, listen: false);
    final data = dashboardVM.dashboard;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: BigChipCard(
                      title: "Daily Sales",
                      value: '${data!.dailySales ?? 'N/A'}',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: BigChipCard(
                      title: "Weekly Sales",
                      value: data.weeklySales.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: BigChipCard(
                      title: "Monthly Sales",
                      value: data.monthlySales.toString(),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ChipCard(
                title: "Total Orders",
                value: data.totalOrders.toString(),
              ),
              const SizedBox(height: 16.0),
              ChipCard(
                title: "Total Sales",
                value: 'Rs. ${data.totalSales}',
              ),
              const SizedBox(height: 16.0),
              ChipCard(
                title: "Total Profit",
                value: 'Rs. ${data.totalProfit.toString()}',
              ),
              const SizedBox(height: 16.0),
              const ChipCard(
                title: "Total Tables",
                value: "0",
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 8.0,
                  bottom: 16.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Employee Overview',
                      style: MyTextStyle.title,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Waiters',
                          style: MyTextStyle.body,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          data.totalWaiters.toString(),
                          style: MyTextStyle.title.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Cooks',
                          style: MyTextStyle.body,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          data.totalCooks.toString(),
                          style: MyTextStyle.title.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Employees',
                          style: MyTextStyle.body,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          data.totalEmployees.toString(),
                          style: MyTextStyle.title.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChipCard extends StatelessWidget {
  final String title;
  final String value;

  const ChipCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyle.body,
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: MyTextStyle.title.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class BigChipCard extends StatelessWidget {
  final String title;
  final String value;

  const BigChipCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyle.body,
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: MyTextStyle.title.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
