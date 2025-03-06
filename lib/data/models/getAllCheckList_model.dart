class GetAllCheckListModelsDTO {
  final String title;
  final String areaId;
  final String areaName;
  final String revisionNumber;

  GetAllCheckListModelsDTO({
    required this.title,
    required this.areaId,
    required this.areaName,
    required this.revisionNumber,
  });

  factory GetAllCheckListModelsDTO.fromMap(Map<String, dynamic> map) {
    return GetAllCheckListModelsDTO(
      title: map['title'],
      areaId: map['areaId'],
      areaName: map['areaName'],
      revisionNumber: map['revisionNumber'],
    );
  }

  get totalItems => null;

  get id => null;
}
