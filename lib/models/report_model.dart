class ReportModel {
  final String reportId;
  final String? patientName;
  final String name;
  final String type;
  final String output;
  final String picture;
  final DateTime timeUploaded;
  ReportModel({
    required this.reportId,
    this.patientName,
    required this.name,
    required this.type,
    required this.output,
    required this.picture,
    required this.timeUploaded,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reportId': reportId,
      'patientName': patientName,
      'name': name,
      'type': type,
      'output': output,
      'picture': picture,
      'timeUploaded': timeUploaded.millisecondsSinceEpoch,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      reportId: map['reportId'] as String,
      patientName: map['patientName'] != null ? map['patientName'] as String : null,
      name: map['name'] as String,
      type: map['type'] as String,
      output: map['output'] as String,
      picture: map['picture'] as String,
      timeUploaded: DateTime.fromMillisecondsSinceEpoch(map['timeUploaded'] as int),
    );
  }

}
