class SectorModel {
  final String id;
  final String name;

  SectorModel({required this.id, required this.name});

  factory SectorModel.fromMap(Map<String, dynamic> map) {
    return SectorModel(id: map['id'], name: map['name']);
  }

  void add(SectorModel area) {}
}
