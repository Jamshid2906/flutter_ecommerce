// class Category{
//   int? id ;
//   String name ;
//   String image ;
//   bool isSelected ;
//   Category({ this.id, required this.name,this.isSelected = false, required this.image});
// }
class Category{
  int? id ;
  String name ;
  String image ;
  bool isSelected ;
  Category({ this.id, required this.name,this.isSelected = false, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id    : json['id'],
        name  : json['name'],
        image : json['image'] ?? null,
      );
}