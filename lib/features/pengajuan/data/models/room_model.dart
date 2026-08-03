class RoomModel {
  final int id;
  final String name;
  final int capacity;

  const RoomModel({
    required this.id,
    required this.name,
    required this.capacity,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] as int,
      name: json['name'] as String,
      capacity: json['capacity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
    };
  }
}
