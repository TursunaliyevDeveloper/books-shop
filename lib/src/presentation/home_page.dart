// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _BooksPageState();
}

class _BooksPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.decimalPattern('uz');
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Kitob sotib oling", style: TextStyle(color: textColor)),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
      ),
      body: Scaffold(),
    );
  }
}
