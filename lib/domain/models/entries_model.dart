class EntriesModel {
  final int id;
  final String title;
  final String type;
  final String? desc;
  final bool? isSecure;

  EntriesModel({
    required this.id,
    required this.title,
    required this.type,
    this.desc,
    this.isSecure,
  });

  factory EntriesModel.fromJson(Map<String, dynamic> json) => EntriesModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      desc: json['desc'],
      isSecure: json['isSecure']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'type': type,
        'isSecure': isSecure
      };
}
