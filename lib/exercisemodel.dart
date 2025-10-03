class ExcerciseModel {
  final String name;
  final String imageUrl;
  ExcerciseModel({required this.name, required this.imageUrl});

  factory ExcerciseModel.fromJson(Map<String, dynamic> json) {
    return ExcerciseModel(
      name: json['name'] ?? 'unknown fact',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
