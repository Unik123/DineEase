class Table {
  int id;
  String number;
  String seats;
  bool isOccupied;

  Table({
    required this.id,
    required this.number,
    required this.seats,
    required this.isOccupied,
  });

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["id"],
        number: json["number"],
        seats: json["seats"],
        isOccupied: json["is_occupied"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "seats": seats,
        "is_occupied": isOccupied,
      };
}
