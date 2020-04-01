class Category {

  Category(this.name, this.id);

  final String name;
  final String id;

  factory Category.fromJson(Map<String,dynamic> json) {
    return Category(json['categoryName'],json['id']);
  }  


}