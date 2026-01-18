import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddAssert extends StatelessWidget {
  TextEditingController assertController= TextEditingController();
  TextEditingController categoryontroller= TextEditingController();
  TextEditingController dateController= TextEditingController();
  AddAssert({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body:Padding(
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
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  labelText: 'Category',
                ),
              ),




              const SizedBox(height: 16.0),
              TextFormField(
                controller: datecontroller,
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: DateTime.now(),
                  );
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