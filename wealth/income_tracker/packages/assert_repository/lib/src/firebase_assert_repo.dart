import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../assert_repository.dart';
import 'package:assert_repository/src/category.dart'; 
import 'package:assert_repository/src/models/assert.dart'; 

class Asset {
  final String assetId;
  // Add other fields as needed

  Asset({required this.assetId});

  AssetEntity toEntity() => AssetEntity(assetId: assetId);

  static Asset fromEntity(AssetEntity entity) => Asset(assetId: entity.assetId);
}

class AssetEntity {
  final String assetId;
  // Add other fields as needed

  AssetEntity({required this.assetId});

  Map<String, dynamic> toDocument() => {'assetId': assetId};

  static AssetEntity fromDocument(Map<String, dynamic> doc) =>
      AssetEntity(assetId: doc['assetId'] as String);
}

class FirebaseAssertRepo implements AssertRepository {
   final categoryCollection = FirebaseFirestore.instance.collection('categories');
   final assertCollection = FirebaseFirestore.instance.collection('assets');

  @override
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

  Future<void> createAsset(Asset asset) async {
    try {
      await assertCollection
        .doc(asset.assetId)
        .set(asset.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<Asset>> getAssets() async {
    try {
      return await assertCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Asset.fromEntity(AssetEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}