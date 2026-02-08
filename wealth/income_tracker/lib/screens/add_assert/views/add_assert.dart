import 'package:assert_repository/assert_repository.dart' as assert_repo;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddAssert extends StatefulWidget {
  const AddAssert({super.key});

  @override
  State<AddAssert> createState() => _AddAssertState();
}

class _AddAssertState extends State<AddAssert> {
  final assert_repo.AssertRepository _assertRepository =
      assert_repo.FirebaseAssertRepo();
  final TextEditingController assertController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime selectDate = DateTime.now();
  bool _isSaving = false;
  List<String> myCategories = [
    'CSE',
    'FD',
    'Saving',
    'Unit',
    'crypto',
    'Treasury Bill',
  ];

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _loadCategories();
  }

  @override
  void dispose() {
    assertController.dispose();
    categoryController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _assertRepository.getCategory();
      if (!mounted || categories.isEmpty) {
        return;
      }

      setState(() {
        myCategories = [
          ...myCategories,
          ...categories.map((category) => category.name),
        ].toSet().toList();
      });
    } catch (_) {
      // Keep default categories when backend fetch fails.
    }
  }

  Future<void> _selectCategory() async {
    if (myCategories.isEmpty) {
      return;
    }

    final selectedCategory = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: myCategories.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final category = myCategories[index];
              return ListTile(
                title: Text(category),
                onTap: () => Navigator.pop(context, category),
              );
            },
          ),
        );
      },
    );

    if (!mounted || selectedCategory == null) {
      return;
    }

    setState(() {
      categoryController.text = selectedCategory;
    });
  }

  Future<void> _saveAsset() async {
    final assetName = assertController.text.trim();
    final category = categoryController.text.trim();

    if (assetName.isEmpty || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter asset name and category.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final assertId = const Uuid().v1();
      await FirebaseFirestore.instance.collection('asserts').doc(assertId).set({
        'assertId': assertId,
        'name': assetName,
        'category': category,
        'date': dateController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Asset added successfully.')),
      );
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add asset: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Add Asset Screen',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: assertController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    labelText: 'Asset Name',
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: categoryController,
                readOnly: true,
                onTap: _selectCategory,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          final categoryNameController = TextEditingController();

                          return AlertDialog(
                            title: const Text('Add Category'),
                            content: TextFormField(
                              controller: categoryNameController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                labelText: 'Name',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final categoryName =
                                      categoryNameController.text.trim();
                                  if (categoryName.isEmpty) {
                                    return;
                                  }

                                  final newCategory = assert_repo.Category(
                                    categoryId: const Uuid().v1(),
                                    name: categoryName,
                                    totalAssert: 0,
                                  );

                                  try {
                                    await _assertRepository
                                        .createCategory(newCategory);
                                    if (!mounted) {
                                      return;
                                    }

                                    setState(() {
                                      myCategories.add(newCategory.name);
                                      categoryController.text = newCategory.name;
                                    });

                                    Navigator.pop(ctx);
                                  } catch (error) {
                                    if (!mounted) {
                                      return;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to save category: $error',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  labelText: 'Category',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  final DateTime? newDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDate: selectDate,
                  );
                  if (newDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  labelText: 'Date',
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00B2E7),
                      Color.fromARGB(255, 101, 10, 117),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: _isSaving ? null : _saveAsset,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Add Asset'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
