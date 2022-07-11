class IncomeSourceModel {
  final int id;
  final String title;
  final String? desc;
  final bool? isSecure;
  IncomeSourceModel(
      {required this.id, required this.title, this.desc, this.isSecure});

  factory IncomeSourceModel.fromJson(Map<String, dynamic> json) =>
      IncomeSourceModel(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        isSecure: json['isSecure'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'isSecure': isSecure,
      };
}
