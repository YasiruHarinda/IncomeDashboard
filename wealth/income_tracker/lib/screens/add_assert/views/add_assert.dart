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
  final TextEditingController assertController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime selectDate = DateTime.now();
  bool _isSaving = false;

  // ✅ simple list of category names
  List<String> myCategories = [];

  // ✅ change these in ONE place if you want different collection names
  final _categoriesCol = FirebaseFirestore.instance.collection('assert_categories');
  final _assertsCol = FirebaseFirestore.instance.collection('asserts');

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
      final snap = await _categoriesCol.orderBy('createdAt', descending: true).get();

      final names = snap.docs
          .map((d) => (d.data()['name'] ?? '').toString().trim())
          .where((name) => name.isNotEmpty)
          .toList();

      if (!mounted) return;

      setState(() {
        // remove duplicates while keeping order
        myCategories = names.toSet().toList();
      });
    } catch (e) {
      // If fetch fails, keep list empty (or you can add defaults)
      // ignore
    }
  }

  Future<void> _selectCategory() async {
    if (myCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No categories yet. Add one using +')),
      );
      return;
    }

    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (_) {
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

    if (!mounted || selected == null) return;

    setState(() {
      categoryController.text = selected;
    });
  }

  Future<void> _addCategoryDialog() async {
    final ctrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(
              hintText: 'Category name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = ctrl.text.trim();
                if (name.isEmpty) return;

                try {
                  // ✅ prevent duplicates (case-insensitive)
                  final existing = await _categoriesCol
                      .where('nameLower', isEqualTo: name.toLowerCase())
                      .limit(1)
                      .get();

                  if (existing.docs.isNotEmpty) {
                    if (!mounted) return;
                    setState(() {
                      categoryController.text = name;
                      if (!myCategories.contains(name)) myCategories.insert(0, name);
                    });
                    Navigator.pop(ctx);
                    return;
                  }

                  final id = const Uuid().v1();
                  await _categoriesCol.doc(id).set({
                    'categoryId': id,
                    'name': name,
                    'nameLower': name.toLowerCase(),
                    'createdAt': FieldValue.serverTimestamp(),
                  });

                  if (!mounted) return;

                  // ✅ update UI immediately (and also set selected)
                  setState(() {
                    myCategories.insert(0, name);
                    categoryController.text = name;
                  });

                  Navigator.pop(ctx);

                  // ✅ optional: re-fetch to be 100% consistent with Firebase ordering
                  // await _loadCategories();
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add category: $e')),
                  );
                }
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
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

      await _assertsCol.doc(assertId).set({
        'assertId': assertId,
        'name': assetName,
        'category': category,
        'date': dateController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Asset added successfully.')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add asset: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
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
              const Text(
                'Add Asset',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: assertController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(FontAwesomeIcons.box, size: 16, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Asset Name',
                  ),
                ),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: categoryController,
                readOnly: true,
                onTap: _selectCategory,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(FontAwesomeIcons.list, size: 16, color: Colors.grey),
                  suffixIcon: IconButton(
                    onPressed: _addCategoryDialog,
                    icon: const Icon(FontAwesomeIcons.plus, size: 16, color: Colors.grey),
                  ),
                  hintText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

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
                      dateController.text = DateFormat('yyyy-MM-dd').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(FontAwesomeIcons.clock, size: 16, color: Colors.grey),
                  hintText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: _isSaving
                    ? const Center(child: CircularProgressIndicator())
                    : TextButton(
                        onPressed: _saveAsset,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
