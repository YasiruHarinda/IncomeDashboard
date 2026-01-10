import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> myTransactionsData = [
  {
    'icon': CupertinoIcons.money_dollar,
    'iconBg': const Color.fromARGB(144, 202, 40, 40),
    'iconColor': const Color.fromARGB(255, 122, 201, 224),
    'name': 'Saving',
    'totalAmount': 'RS 45000.00',
    'date': 'Today',
  },
  {
    'icon': CupertinoIcons.money_dollar,
    'iconBg': const Color.fromARGB(69, 33, 149, 243),
    'iconColor': Colors.white,
    'name': 'CSE',
    'totalAmount': 'RS 50000.00',
    'date': 'Today',
  },
  {
    'icon': CupertinoIcons.money_dollar,
    'iconBg': Colors.green,
    'iconColor': Colors.white,
    'name': 'FD',
    'totalAmount': 'RS 100000.00',
    'date': 'Today',
  },
];
