class Payment {
  int? id;
  int? order;
  double? tax;
  double? discount;
  double? amount;
  String? paymentMethod;
  String? paymentStatus;
  DateTime? createdAt;
  String? cashier;
  double? total;

  Payment({
    this.id,
    this.order,
    this.tax,
    this.discount,
    this.amount,
    this.paymentMethod,
    this.paymentStatus,
    this.createdAt,
    this.cashier,
    this.total,
  });

  factory Payment.fromJson(Map<String?, dynamic> json) => Payment(
        id: json["id"],
        order: json["order"],
        tax: json["tax"],
        discount: json["discount"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        cashier: json["cashier_by_full_name"],
        createdAt: DateTime.parse(json["created_at"]),
        total: json["total"],
      );

  Map<String?, dynamic> toJson() => {
        "order": order,
        "tax": tax,
        "discount": discount,
        "amount": amount,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
      };
}
