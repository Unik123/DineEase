import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/restro/dashboard_vm.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel()..fetchDashboardData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dashboard",
            style: MyTextStyle.title,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalpadding * 1.5),
          child: Consumer<DashboardViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = viewModel.dashboard;

              if (data == null) {
                return const Center(child: Text('Failed to load data'));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 11,
                        mainAxisSpacing: 11,
                        childAspectRatio: 2.05 / 1,
                      ),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return buildDashboardCard(
                              "Daily Sales",
                              data.dailySales ?? 0.0,
                              data.dailyOrders ?? 0,
                            );
                          case 1:
                            return buildDashboardCard(
                              "Weekly Sales",
                              data.weeklySales ?? 0.0,
                              data.weeklyOrders ?? 0,
                            );
                          case 2:
                            return buildDashboardCard(
                              "Monthly Sales",
                              data.monthlySales ?? 0.0,
                              data.monthlyOrders ?? 0,
                            );
                          case 3:
                            return buildDashboardCard(
                              "Total Sales",
                              data.totalSales ?? 0.0,
                              data.totalOrders ?? 0,
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildDashboardCard(String title, double sales, int orders) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.12),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalpadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.verticalpadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs ${sales.toStringAsFixed(1)}",
                  style: MyTextStyle.subtitle
                      .copyWith(fontSize: 20, color: Colors.teal),
                ),
                Container(
                  height: 29,
                  width: 29,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${(sales / 100).toStringAsFixed(1)}%",
                      style: MyTextStyle.subtitle.copyWith(fontSize: 9),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              title,
              style: MyTextStyle.subtitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppConstants.verticalpadding * 1.5),
            LinearProgressIndicator(
              value: 0.76,
              color: Colors.teal,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppConstants.verticalpadding * 2),
                    Text(
                      "Compared to 6% profit today)",
                      style: MyTextStyle.thin
                          .copyWith(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Our employees: 30",
                      style: MyTextStyle.subtitle
                          .copyWith(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Total waiters: 30",
                      style: MyTextStyle.subtitle
                          .copyWith(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "We have best 13 (cooks)",
                      style: MyTextStyle.thin
                          .copyWith(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                CircularPercentIndicator(
                  radius: 30,
                  lineWidth: 5,
                  percent: 0.70,
                  center: Column(
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "375",
                        style: MyTextStyle.title
                            .copyWith(fontSize: 11, color: Colors.teal),
                      ),
                      Text(
                        "Orders",
                        style: MyTextStyle.subtitle.copyWith(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  progressColor: Colors.orange,
                  backgroundColor: Colors.grey.shade200,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
