class ExpenseCategoriesModel {
  final int id;
  final String title;
  final String? desc;
  ExpenseCategoriesModel({
    required this.id,
    required this.title,
    this.desc,
  });

  factory ExpenseCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoriesModel(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
      };
}
