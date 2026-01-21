import '../entities/entities.dart';
class Category {
  String categoryId;
  String name;
  int totalAssert;


  Category({
    required this.categoryId,
    required this.name,
    required this.totalAssert,
    
  });

  static final empty = Category(
    categoryId: '', 
    name: '', 
    totalAssert: 0, 
   
  );
  

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      totalAssert: totalAssert,
     
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      totalAssert: entity.totalAssert,
      
    );
  }
}