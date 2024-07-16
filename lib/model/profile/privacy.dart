
class Privacy {
    int id;
    String title;
    String content;
    DateTime createdAt;

    Privacy({
        required this.id,
        required this.title,
        required this.content,
        required this.createdAt,
    });

    factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created_at": createdAt.toIso8601String(),
    };
}
