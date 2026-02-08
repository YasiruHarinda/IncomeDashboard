import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:assert_repository/assert_repository.dart';
import 'package:income_tracker/screens/add_assert/blocs/create_categorybloc/create_category_bloc.dart';

Future<Category?> getCategoryCreation(BuildContext context) {
  TextEditingController categoryNameController = TextEditingController();
  bool isLoading = false;
  Category category = Category.empty;

  return showDialog<Category>(
    context: context,
    builder: (ctx) {
      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: StatefulBuilder(
          builder: (ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategoryLoading) {
                  setState(() => isLoading = true);
                } 
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx, category);
                }
              },
              child: AlertDialog(
                title: const Text('Add Category'),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: categoryNameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Category Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  if (categoryNameController.text.trim().isEmpty) {
                                    return;
                                  }

                                  category = Category(
                                    categoryId: const Uuid().v1(),
                                    name: categoryNameController.text.trim(),
                                    totalAssert: 0,
                                  );

                                  context
                                      .read<CreateCategoryBloc>()
                                      .add(CreateCategory(category));
                                },
                                child: const Text('Save'),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
