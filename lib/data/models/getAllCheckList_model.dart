class GetAllCheckListModelsDTO {
  final String title;
  final String areaid;
  final String areaname;

  GetAllCheckListModelsDTO({
    required this.title,
    required this.areaid,
    required this.areaname,
  });

  factory GetAllCheckListModelsDTO.fromMap(Map<String, dynamic> map) {
    return GetAllCheckListModelsDTO(
      title: map['title'],
      areaid: map['areaid'],
      areaname: map['areaname'],
    );
  }
  }

