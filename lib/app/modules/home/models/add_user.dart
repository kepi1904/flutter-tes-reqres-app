class AddUserModel {
  final String name;
  final String job;
  final String id;
  final DateTime createdAt;

  AddUserModel({
    required this.name,
    required this.job,
    required this.id,
    required this.createdAt,
  });

  factory AddUserModel.fromJson(Map<String, dynamic> json) {
    return AddUserModel(
      name: json['name'],
      job: json['job'],
      id: json['id'].toString(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
