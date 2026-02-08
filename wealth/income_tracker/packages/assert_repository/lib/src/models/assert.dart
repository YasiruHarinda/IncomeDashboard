import 'package:assert_repository/assert_repository.dart';

class Assert {
  final String assertId;
  final Category category;
  final DateTime date;
  final int amount;

  const Assert({
    required this.assertId,
    required this.category,
    required this.date,
    required this.amount,
  });

  static final empty = Assert(
    assertId: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0,
  );

  AssertEntity toEntity() {
    return AssertEntity(
      assertId: assertId,
      category: category,
      date: date,
      amount: amount,
    );
  }

  static Assert fromEntity(AssertEntity entity) {
    return Assert(
      assertId: entity.assertId,
      category: entity.category,
      date: entity.date,
      amount: entity.amount,
    );
  }
}

class AssertEntity {
  final String assertId;
  final Category category;
  final DateTime date;
  final int amount;

  const AssertEntity({
    required this.assertId,
    required this.category,
    required this.date,
    required this.amount,
  });
}

