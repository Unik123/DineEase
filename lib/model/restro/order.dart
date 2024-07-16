class Order {
   int? id;
   String orderTime;
   String status;
   int? table;
   List<OrderItem> orderItems;
   String? orderedBy;

  Order({
    required this.id,
    required this.orderTime,
    required this.status,
    required this.table,
    required this.orderItems,
    required this.orderedBy,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderTime: json['order_time'],
      status: json['status'],
      table: json['table'],
      orderItems: (json['order_items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      orderedBy: json['ordered_by_full_name'],
    );
  }
}

class OrderItem {
   int? id;
   int? item;
   String quantity;

  OrderItem({
     this.id,
     this.item,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      item: json['item'],
      quantity: json['quantity'],
    );
  }
}
