class Dashboard {
   int? totalOrders;
   double? totalSales;
   int? totalEmployees;
   int? totalWaiters;
   int? totalCooks;
   double? totalProfit;
   int? dailyOrders;
   double? dailySales;
   double? dailyProfit;
   int? weeklyOrders;
   double? weeklySales;
   double? weeklyProfit;
   int? monthlyOrders;
   double? monthlySales;
   double? monthlyProfit;


  Dashboard({
     this.totalOrders,
     this.totalSales,
     this.totalEmployees,
     this.totalWaiters,
     this.totalCooks,
     this.totalProfit,
     this.dailyOrders,
     this.dailySales,
     this.dailyProfit,
     this.weeklyOrders,
     this.weeklySales,
     this.weeklyProfit,
     this.monthlyOrders,
     this.monthlySales,
     this.monthlyProfit,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      totalOrders: json['total_orders'],
      totalSales: json['total_sales'],
      totalEmployees: json['total_employees'],
      totalWaiters: json['total_waiters'],
      totalCooks: json['total_cooks'],
      totalProfit: json['total_profit'],
      dailyOrders: json['daily_orders'],
      dailySales: json['daily_sales'],
      dailyProfit: json['daily_profit'],
      weeklyOrders: json['weekly_orders'],
      weeklySales: json['weekly_sales'],
      weeklyProfit: json['weekly_profit'],
      monthlyOrders: json['monthly_orders'],
      monthlySales: json['monthly_sales'],
      monthlyProfit: json['monthly_profit'],
    );
  }

  get length => null;
}
