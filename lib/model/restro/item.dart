class Item {
  int? id;
  String name;
  String price;
  String image;
  String? description;
  String department;

  Item({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    this.description,
    required this.department,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "description": description,
        "department": department,
      };
}
