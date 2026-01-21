import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assert_repository/src/assert_repository.dart';
import 'package:assert_repository/src/category.dart'; // Make sure this path points to where Category is defined

class FirebaseAssertRepo implements AssertRepository {
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
	final assertCollection = FirebaseFirestore.instance.collection('asserts');


  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
        .doc(category.categoryId)
        .set(category.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      return await categoryCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Category.fromEntity(CategoryEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // @override
  // Future<void> createAssert(Assert assert) async {
  //   try {
  //     await assertCollection
  //       .doc(assert.assertId)
  //       .set(assert.toEntity().toDocument());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

  // @override
  // Future<List<Assert>> getAsserts() async {
  //   try {
  //     return await assertCollection
  //       .get()
  //       .then((value) => value.docs.map((e) => 
  //         Assert.fromEntity(AssertEntity.fromDocument(e.data()))
  //       ).toList());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

}