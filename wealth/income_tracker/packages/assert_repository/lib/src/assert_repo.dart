//import 'package:assert_repository/assert_repository.dart';

import '../assert_repository.dart';

abstract class AssertRepository {

  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();

  // Future<void> createExpense(assert expense);

  // Future<List<Assert>> getExpenses();
}