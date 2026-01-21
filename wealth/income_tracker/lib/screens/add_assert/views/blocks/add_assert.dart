import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddAssert extends StatefulWidget {
  const AddAssert({super.key});

  @override
  State<AddAssert> createState() => _AddAssertState();
}

class _AddAssertState extends State<AddAssert> {
  TextEditingController assertController = TextEditingController();
  TextEditingController categoryontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  List <String>myCategories = [
    'CSE',
    'FD',
    'Saving',
    'Unit',
    'crypto',
    'Treasury Bill'
  ];

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                width:MediaQuery.of(context).size.width*0.8,
                child: TextFormField(
                  controller:assertController,
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
                controller:categoryontroller,
                readOnly: true,
                onTap: (){

                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.list,
                    size:16,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
  onPressed: () {
    final TextEditingController newCategoryController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: TextFormField(
            controller: newCategoryController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
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
              onPressed: () {
                final String name = newCategoryController.text.trim();
                if (name.isEmpty) return;

                setState(() {
                  myCategories.add(name);           // add to list
                  categoryontroller.text = name;    // set Category field text
                });

                Navigator.pop(ctx);
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
                onTap: () async{
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: selectDate,
                  );
                  if(newDate!=null){
                    setState((){
                       dateController.text = DateFormat('yyyy-MM-dd').format(newDate);
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
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00B2E7),
                      Color.fromARGB(255, 101, 10, 117),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Add Asset'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}