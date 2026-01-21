class CategoryEntity {
  String categoryId;
  String name;
  int totalAssert;
 

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.totalAssert,
    
  });

  Map<String, Object?> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalAssert': totalAssert,
      
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
      categoryId: doc['categoryId'],
      name: doc['name'],
      totalAssert: doc['totalAssert'],
    
    );
  }
}