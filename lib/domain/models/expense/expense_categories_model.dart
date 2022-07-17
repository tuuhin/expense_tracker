class ExpenseCategoriesModel {
  final int id;
  final String title;
  final String? desc;

  ExpenseCategoriesModel({
    required this.id,
    required this.title,
    this.desc,
  });
}
