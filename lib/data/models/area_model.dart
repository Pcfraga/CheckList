class AreaModel {
  final String title;
  final String areaid;
  final String areaname;
  

  AreaModel({
    required this.title,
    required this.areaid,
    required this.areaname,
  });

  factory AreaModel.fromMap(Map<String, dynamic> map) {
    return AreaModel(
      title: map['title'],
      areaid: map['areaid'],
      areaname: map['areaname'],
    );
  }
  }

