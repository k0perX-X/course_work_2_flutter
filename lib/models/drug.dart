class Drug {

  final int id;
  final String name;
  final String? note;

  Drug(this.id, this.name, {this.note});

  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      json["id"],
      json["name"],
      note: json["note"]
    );
  }
}