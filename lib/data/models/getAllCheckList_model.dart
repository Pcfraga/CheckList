class GetAllCheckListModelsDTO {
  final String title;
  final String areaId;
  final String areaName;

  GetAllCheckListModelsDTO({
    required this.title,
    required this.areaId,
    required this.areaName,
  });

  factory GetAllCheckListModelsDTO.fromMap(Map<String, dynamic> map) {
    return GetAllCheckListModelsDTO(
      title: map['title'],
      areaId: map['areaId'],
      areaName: map['areaName'],
    );
  }
}
