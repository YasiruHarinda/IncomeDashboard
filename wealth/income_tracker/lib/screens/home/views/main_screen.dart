import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:income_tracker/data/data.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [

          // ================= HEADER =================
          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF00B2E7),
                          Color.fromARGB(255, 101, 10, 117),
                        ],
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome!",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "Yasiru Harinda",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(CupertinoIcons.settings),
                onPressed: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ================= NET WORTH CARD =================
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF00B2E7),
                  Color.fromARGB(255, 101, 10, 117),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Net Worth',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Rs 4800.00',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      MiniStat(title: 'Cash', value: 'Rs 2500'),
                      MiniStat(title: 'Investments', value: 'Rs 25M'),
                      MiniStat(title: 'Liabilities', value: 'Rs 800'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // ================= TRANSACTIONS HEADER =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transactions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ================= TRANSACTIONS LIST =================
// ================= TRANSACTIONS LIST =================
          Expanded(
            child: ListView.builder(
              itemCount: myTransactionsData.length,
              itemBuilder: (context, i) {
                final tx = myTransactionsData[i];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // LEFT SIDE
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: tx['iconBg'],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                tx['icon'],
                                color: tx['iconColor'],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              tx['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        // RIGHT SIDE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              tx['totalAmount'],
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tx['date'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// ================= MINI STAT WIDGET =======================
//////////////////////////////////////////////////////////////

class MiniStat extends StatelessWidget {
  final String title;
  final String value;

  const MiniStat({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
